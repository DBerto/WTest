//
//  LoadingScreen.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

// MARK: Navigation Layer

protocol LoadingScreenWireframeInterface: WireframeInterface {

}

// MARK: User Interface Layer

protocol LoadingScreenViewInterface: class {
    func updateView(with viewModel: LoadingViewModel)
}

protocol LoadingScreenEventHandler: class {
    func viewIsLoaded()
}

// MARK: Business Layer

protocol LoadingScreenInteractorInterface: class {

}

protocol LoadingScreenPresenterInterface: class {

}
