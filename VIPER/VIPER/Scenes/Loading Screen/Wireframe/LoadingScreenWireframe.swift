//
//  LoadingScreenWireframe.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit
import WTestCommon

class LoadingScreenWireframe: BaseWireframe, LoadingScreenWireframeInterface {
    
    private let view: LoadingScreenViewController
    private let interactor: LoadingScreenInteractorInterface
    private let presenter: LoadingScreenPresenterInterface
    
    init(view: LoadingScreenViewController, interactor: LoadingScreenInteractorInterface,
         presenter: LoadingScreenPresenterInterface) {
        self.view = view
        self.interactor = interactor
        self.presenter = presenter
        super.init(viewController: view)
    }
    
    // MARK: - LoadingScreenWireframeInterface
    
    func openMainMenu() {
        let mainMenuWirefranme = MainScreenBuilder().makeModule()
        mainMenuWirefranme.viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.setRootWireframe(mainMenuWirefranme)
    }
    
}
