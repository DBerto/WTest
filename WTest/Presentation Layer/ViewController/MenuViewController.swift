//
//  MenuViewController.swift
//  WTest
//
//  Created by David Berto on 28/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: BaseViewController{
    
    // MARK: UIProperties
    @IBOutlet weak var listaCodigosPostaisButton: UIButton!
    @IBOutlet weak var listaColecaoArtigosButton: UIButton!
    @IBOutlet weak var formularioButton: UIButton!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()        
        formularioButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Functions
}
