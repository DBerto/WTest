//
//  LoadingScreenViewModel.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import Combine

protocol LoadingScreenViewModelType: ViewModelType { }

final class LoadingScreenViewModel: LoadingScreenViewModelType {
    
    // MARK: - Properties
    
    private let postalCodeUseCase: PostalCodeUseCase
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
    
    // MARK: - Init
    
    init(postalCodeUseCase: PostalCodeUseCase,
         coordinator: LoadingScreenCoordinatorType) {
        self.postalCodeUseCase = postalCodeUseCase
        self.coordinator = coordinator
    }
    
    // MARK: - Transform
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        
        input.viewDidLoadTrigger
            .sink { [weak self] in
                self?.viewDidLoadTrigger()
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
    
    private func viewDidLoadTrigger() {
        loadingViewModel.downloadingLabel = R.string.localizable.savingLabel()
        dataSourceModel.send(loadingViewModel)
        
        executeInBackgroundThread { [weak self] in
            let result = self?.postalCodeUseCase.downloadPostalCodes()
            switch result {
            case .success(let postalCodes):
                executeInMainThread { [weak self] in
                    _ = self?.postalCodeUseCase.savePostalCodes(postalCodes)
                    self?.coordinator.perform(.showMainScreen)
                }
            case .failure(let error):
                self?.errorTracker.send(error)
            default: break
            }
        }
    }
}
