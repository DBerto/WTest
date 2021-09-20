//
//  LoadingScreenViewModel.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon

protocol LoadingScreenViewModelType: ViewModelType { }

class LoadingScreenViewModel: LoadingScreenViewModelType {
    
    // MARK: - Properties
    
    private let postalCodeUseCase: PostalCodeUseCase
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    private lazy var loadingViewModel: LoadingViewModel = {
        return  LoadingViewModel(title: R.string.localizable.appTitle(),
                                 image: #imageLiteral(resourceName: "post-box"),
                                 downloadingLabel: R.string.localizable.downloadingLabel(),
                                 isDownloading: true)
    }()
    
    // MARK: - Init
    
    init(postalCodeUseCase: PostalCodeUseCase) {
        self.postalCodeUseCase = postalCodeUseCase
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
}
