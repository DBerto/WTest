//
//  MainScreenWireframe.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

class  MainScreenWireframe: BaseWireframe,  MainScreenWireframeInterface {
    
    private let view: MainScreenViewController
    private let interactor: MainScreenInteractorInterface
    private let presenter: MainScreenPresenterInterface
    
    init(view: MainScreenViewController, interactor: MainScreenInteractorInterface,
         presenter: MainScreenPresenterInterface) {
        self.view = view
        self.interactor = interactor
        self.presenter = presenter
        super.init(viewController: view)
    }
    
    func openPostalCodes() {
        let postalCodesWireframe = PostalCodesBuilder().makeModule()
        self.navigationController?.pushWireframe(postalCodesWireframe)
    }
}

