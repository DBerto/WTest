//
//  LoadingScreenPresenter.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

class LoadingScreenPresenter: LoadingScreenEventHandler, LoadingScreenPresenterInterface {
    
    // MARK: - Properties
    
    var wireframe: LoadingScreenWireframeInterface!
    var view: LoadingScreenViewInterface!
    var interactor: LoadingScreenInteractorInterface!
    
    lazy var viewModel: LoadingViewModel = {
        return  LoadingViewModel(title: R.string.localizable.appTitle(), image: #imageLiteral(resourceName: "post-box"),
                                 downloadingLabel: R.string.localizable.downloadingLabel(),
                                 isDownloading: true)
    }()
    
    // MARK: - LoadingScreenEventHandler
    
    func viewIsLoaded() {
        view.updateView(with: viewModel)
    }
    
    func viewAppeared() {
        interactor.fetchPostalCodes()
    }
    
    // MARK: - LoadingScreenInteractorInterface
    
    func postalCodeFetchSucceed(_ postalCodes: [PostalCode]) {
        viewModel.downloadingLabel = R.string.localizable.savingLabel()
        view.updateView(with: viewModel)
        DispatchQueue.main.async { [weak self] in
            self?.interactor.savePostalCodes(postalCodes)
        }
    }
    
    func postalCodeFetchFailed(_ error: Error) {
        view.showError(error)
    }
    
    func postalCodeSaveSucceed() {
        
    }
    
    func postalCodeSaveFailed(_ error: Error) {
        view.showError(error)
    }
}
