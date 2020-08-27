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

protocol LoadingScreenViewInterface: ViewInterface {
    func updateView(with viewModel: LoadingViewModel)
}

protocol LoadingScreenEventHandler: class {
    func viewIsLoaded()
    func viewAppeared()
}

// MARK: Business Layer

protocol LoadingScreenInteractorInterface: class {
    func fetchPostalCodes()
}

protocol LoadingScreenPresenterInterface: class {
    func postalCodeFetchFailed(_ error: Error)
}
