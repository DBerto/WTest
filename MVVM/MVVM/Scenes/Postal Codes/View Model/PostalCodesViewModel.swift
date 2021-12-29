//
//  PostalCodesViewViewModel.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import WTestCommon
import WTestDomain
import Combine

protocol PostalCodesViewModelType: ViewModelType { }

final class PostalCodesViewModel: PostalCodesViewModelType {
    
    // MARK: - Properties
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
        let searchRequestTrigger: Driver<String?>
    }
    
    struct Output {
        let isSearching: ActivityTracker
        let dataSourceModel: PassthroughSubject<PostalCodeFieldsViewModel, Never>
    }
    
    private let useCase: PostalCodeUseCaseType
    private let coordinator: PostalCodesCoordinatorType
    private var postalCodes: [PostalCode] = []
    
    // MARK: - Publishers
    
    private let isSearching: ActivityTracker = .init(false)
    private let dataSourceModel: PassthroughSubject<PostalCodeFieldsViewModel, Never> = .init()
    
    // MARK: - Init
    
    init(useCase: PostalCodeUseCaseType,
         coordinator: PostalCodesCoordinatorType) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    // MARK: - Transform
    
    private let tempDisposeBag: CancellableBag = .init()
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        
        input.viewDidLoadTrigger
            .flatMap { [weak self] _ -> ObservableType<[PostalCode]> in
                guard let self = self else { return Empty<[PostalCode], Never>().asObservable() }
                return self.useCase.fetchPostalCodes()
                    .trackActivity(self.isSearching)
            }
            .replaceError(with: [])
            .sink { [weak self] postalCodes in
                self?.postalCodes = postalCodes
                self?.reloadDataSource()
            }
            .store(in: disposeBag)
        
        input.searchRequestTrigger
            .compactMap { $0 }
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchTerm in
                self?.searchRequestTrigger(searchTerm)
            }
            .store(in: disposeBag)
        
        return Output(isSearching: isSearching,
                      dataSourceModel: dataSourceModel)
    }
    
    
    // MARK: - Helpers
    
    private func searchRequestTrigger(_ searchTerm: String) {
        tempDisposeBag.cancel()
        
        useCase.searchPostalCodes(withText: searchTerm)
            .trackActivity(isSearching)
            .replaceError(with: [])
            .sink { [weak self] postalCodes in
                self?.postalCodes = postalCodes
                self?.reloadDataSource()
            }
            .store(in: tempDisposeBag)
    }
    
    private func reloadDataSource() {
        let postalCodeFields = postalCodes.map { PostalCodeFieldViewModel(local: $0.local,
                                                                          number: $0.number) }
        let postalCodesVM = PostalCodeFieldsViewModel(postalCodeFields: postalCodeFields)
        dataSourceModel.send(postalCodesVM)
    }
}
