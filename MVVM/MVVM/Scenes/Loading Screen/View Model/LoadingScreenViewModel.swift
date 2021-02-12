//
//  LoadingScreenViewModel.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon

class LoadingScreenViewModel: ViewModelType{
    
    // MARK: - Properties
    
    private let postalCodeUseCase: PostalCodeUseCase
    
    struct Input {
        let viewDidLoadTrigger: Variable<Void?>
        let viewWillAppearTrigger: Variable<Void?>
    }
    
    struct Output {
        let loadingViewModel: Variable<LoadingViewModel?>
    }
    
    private lazy var loadingViewModel: LoadingViewModel = {
        return  LoadingViewModel(title: R.string.localizable.appTitle(), image: #imageLiteral(resourceName: "post-box"),
                                 downloadingLabel: R.string.localizable.downloadingLabel(),
                                 isDownloading: true)
    }()
    
    init(postalCodeUseCase: PostalCodeUseCase) {
        self.postalCodeUseCase = postalCodeUseCase
    }
    
    // MARK: - Transform
    
    func transform(input: Input) -> Output {
        let outputResult: Variable<LoadingViewModel?> = .init(nil)
       
        input.viewDidLoadTrigger.onUpdate = { [weak self] (trigger) in
            guard trigger != nil else { return }
            outputResult.value = self?.loadingViewModel
        }
        
        input.viewWillAppearTrigger.onUpdate = { [weak self] (trigger) in
            guard trigger != nil else { return }
            outputResult.value = self?.loadingViewModel
        }
        
        return Output(loadingViewModel: outputResult)
    }
    
}
