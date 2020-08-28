//
//  MainScreen.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

// MARK: Navigation Layer

protocol MainScreenWireframeInterface: WireframeInterface {
    func openPostalCodes()
}

// MARK: User Interface Layer

protocol MainScreenViewInterface: ViewInterface {
    
}

protocol MainScreenEventHandler: class {
    func postalCodesButtonPressed()
}

// MARK: Business Layer

protocol MainScreenInteractorInterface: class {
    
}

protocol MainScreenPresenterInterface: class {
    
}
