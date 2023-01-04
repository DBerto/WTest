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

protocol PostalCodesViewModelProtocol: ViewModelProtocol { }

final class PostalCodesViewModel: PostalCodesViewModelProtocol {
    // MARK: - Enums
    
    enum Action {
        case viewDidLoad
        case reloadDataSource
        case fetchPostalCodes
        case search(String)
    }
    
    enum Strings {
        
    }
    
    // MARK: - Input/Output
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
        let searchRequestTrigger: Driver<String?>
    }
    
    struct Output {
        let isSearching: ActivityTracker
        let dataSourceModel: PassthroughSubject<PostalCodeFieldsViewModel, Never>
    }
    
    // MARK: - Properties
    
    private let useCase: PostalCodeUseCaseProtocol
    private let coordinator: PostalCodesCoordinatorProtocol
    private var postalCodes: [PostalCode] = []
    
    // MARK: - Publishers
    
    private let isSearching: ActivityTracker = .init(false)
    private let dataSourceModel: PassthroughSubject<PostalCodeFieldsViewModel, Never> = .init()
    
    // MARK: - Init
    
    init(useCase: PostalCodeUseCaseProtocol,
         coordinator: PostalCodesCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    // MARK: - Transform
    
    private let endpointsBag: CancellableBag = .init()
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
            .sink { [unowned self] searchTerm in
                performAction(.search(searchTerm))
            }
            .store(in: disposeBag)
        
        return Output(isSearching: isSearching,
                      dataSourceModel: dataSourceModel)
    }
    
    
    // MARK: - Helpers
    
    private func performAction(_ action: Action) {
        switch action {
        case .viewDidLoad:
            performAction(.reloadDataSource)
            performAction(.fetchPostalCodes)
        case .reloadDataSource:
            reloadDataSource()
        case .fetchPostalCodes:
            fetchPostalCodes()
        case .search(let searchTerm):
            searchRequestBy(searchTerm)
        }
    }
    
    private func fetchPostalCodes() {
        endpointsBag.cancel()
        
        useCase.fetchPostalCodes()
            .trackActivity(isSearching)
            .replaceError(with: [])
            .sink { [weak self] postalCodes in
                self?.postalCodes = postalCodes
                self?.reloadDataSource()
            }
            .store(in: endpointsBag)
    }
    
    private func searchRequestBy(_ searchTerm: String) {
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
