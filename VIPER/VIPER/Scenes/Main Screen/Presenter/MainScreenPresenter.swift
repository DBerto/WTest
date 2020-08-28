//
//  MainScreenPresenter.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

class MainScreenPresenter: MainScreenEventHandler, MainScreenPresenterInterface {
    
    // MARK: - Properties
    
    weak var view: MainScreenViewInterface!
    var wireframe: MainScreenWireframeInterface!
    var interactor: MainScreenInteractorInterface!
    
    // MARK: - MainScreenEventHandler

}
