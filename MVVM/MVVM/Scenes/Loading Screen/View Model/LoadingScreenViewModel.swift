//
//  LoadingScreenViewModel.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import WTestDomain
import Combine

protocol LoadingScreenViewModelType: ViewModelType { }

final class LoadingScreenViewModel: LoadingScreenViewModelType {
    
    // MARK: - Properties
    
    private let postalCodeUseCase: PostalCodeUseCaseType
    private let coordinator: LoadingScreenCoordinatorType
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }
    
    struct Output {
        let dataSourceModel: PassthroughSubject<LoadingViewModel, Never>
    }
    
    private lazy var loadingViewModel: LoadingViewModel = {
        LoadingViewModel(title: R.string.localizable.appTitle(),
                         image: #imageLiteral(resourceName: "post-box"),
                         downloadingLabel: R.string.localizable.downloadingLabel(),
                         isDownloading: true)
    }()
    
    // MARK: - Publishers
    
    private let dataSourceModel: PassthroughSubject<LoadingViewModel, Never> = .init()
    private let errorTracker: ErrorTracker = .init()
    private var disposeBag: CancellableBag!
    
    // MARK: - Init
    
    init(postalCodeUseCase: PostalCodeUseCaseType,
         coordinator: LoadingScreenCoordinatorType) {
        self.postalCodeUseCase = postalCodeUseCase
        self.coordinator = coordinator
    }
    
    // MARK: - Transform
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        self.disposeBag = disposeBag
        
        input.viewDidLoadTrigger
            .sink { [weak self] _ in
                self?.reloadDataSource()
                
                executeInBackgroundThread {
                    self?.downloadPostalCodes()
                }
            }
            .store(in: disposeBag)
        
        errorTracker
            .asDriver()
            .sink { [weak self] error in
                self?.coordinator.perform(.error(error))
            }
            .store(in: disposeBag)
        
        return Output(dataSourceModel: dataSourceModel)
    }
    
    
    // MARK: - Helpers
    
    private func reloadDataSource() {
        dataSourceModel.send(loadingViewModel)
    }
    
    private func downloadPostalCodes() {
        postalCodeUseCase.downloadPostalCodes()
            .trackError(errorTracker)
            .asDriver()
            .sink { [weak self] postalCodes in
                self?.loadingViewModel.downloadingLabel = R.string.localizable.savingLabel()
                self?.reloadDataSource()
                
                executeInBackgroundThread {
                    self?.savePostalCodes(postalCodes)
                }
            }
            .store(in: disposeBag)
    }
    
    private func savePostalCodes(_ postalCodes: [PostalCode]) {
        postalCodeUseCase.savePostalCodes(postalCodes)
            .trackError(errorTracker)
            .asDriver()
            .sink { [weak self] postalCodes in
                self?.coordinator.perform(.showMainScreen)
            }
            .store(in: disposeBag)
    }
}
