//
//  LoadingScreenPresenter.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

class LoadingScreenPresenter: LoadingScreenEventHandler, LoadingScreenPresenterInterface {
    
    // MARK: - Properties
    
    weak var wireframe: LoadingScreenWireframeInterface!
    weak var view: LoadingScreenViewInterface!
    weak var interactor: LoadingScreenInteractorInterface!
    
    // MARK: - LoadingScreenEventHandler
    
    func viewIsLoaded() {
        let viewModel = LoadingViewModel(title: "Teste title", image: #imageLiteral(resourceName: "post-box"),
                                         downloadingLabel: "Cenas a carregar", isDownloading: true)
        view.updateView(with: viewModel)
    }
}
