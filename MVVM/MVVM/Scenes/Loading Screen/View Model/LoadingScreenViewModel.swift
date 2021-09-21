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

class LoadingScreenViewModel: LoadingScreenViewModelType {
    
    // MARK: - Properties
    
    private let postalCodeUseCase: PostalCodeUseCase
    
    struct Input {
        let viewDidLoadTrigger: Driver<Void>
    }
    
    struct Output {
        let dataSourceModel: PassthroughSubject<LoadingViewModel, Never>
    }
    
    private lazy var loadingViewModel: LoadingViewModel = {
        return  LoadingViewModel(title: R.string.localizable.appTitle(),
                                 image: #imageLiteral(resourceName: "post-box"),
                                 downloadingLabel: R.string.localizable.downloadingLabel(),
                                 isDownloading: true)
    }()
    
    // MARK: - Publishers
    
    private let dataSourceModel: PassthroughSubject<LoadingViewModel, Never> = .init()
    private let errorTracker: ErrorTracker = .init()
    
    // MARK: - Init
    
    init(postalCodeUseCase: PostalCodeUseCase) {
        self.postalCodeUseCase = postalCodeUseCase
    }
    
    // MARK: - Transform
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output {
        
        input.viewDidLoadTrigger
            .sink { [weak self] in
                self?.viewDidLoadTrigger()
            }
            .store(in: disposeBag)
        
        return Output(dataSourceModel: dataSourceModel)
    }
    
    
    // MARK: - Helpers
    
    private func viewDidLoadTrigger() {
        let result = postalCodeUseCase.downloadPostalCodes()
        switch result {
        case .success(let postalCodes):
            loadingViewModel.downloadingLabel = R.string.localizable.savingLabel()
            _ = postalCodeUseCase.savePostalCodes(postalCodes)
            dataSourceModel.send(self.loadingViewModel)
        case .failure(let error):
            errorTracker.send(error)
        }
    }
}
