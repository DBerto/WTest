//
//  PostalCodesWireframe.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit
import WTestCommon

class  PostalCodesWireframe: BaseWireframe,  PostalCodesWireframeInterface {
    
    private let view: PostalCodesViewController
    private let interactor: PostalCodesInteractorInterface
    private let presenter: PostalCodesPresenterInterface
    
    init(view: PostalCodesViewController, interactor: PostalCodesInteractorInterface,
         presenter: PostalCodesPresenterInterface) {
        self.view = view
        self.interactor = interactor
        self.presenter = presenter
        super.init(viewController: view)
    }
}
