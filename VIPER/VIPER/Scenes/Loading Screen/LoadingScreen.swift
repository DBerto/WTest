//
//  LoadingScreen.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

// MARK: Navigation Layer

protocol LoadingScreenWireframeInterface: WireframeInterface {
    func openMainMenu()
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
    func savePostalCodes(_ postalCodes: [PostalCode])
}

protocol LoadingScreenPresenterInterface: class {
    func postalCodeFetchSucceed(_ postalCodes: [PostalCode])
    func postalCodeFetchFailed(_ error: Error)
    func postalCodeSaveSucceed()
    func postalCodeSaveFailed(_ error: Error)
}
