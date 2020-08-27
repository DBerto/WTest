//
//  BaseViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

protocol ViewInterface: class {
    func showError(_ error: Error)
}

class BaseViewController: UIViewController {
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func showAlert(with title: String? = nil, message: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: R.string.localizable.alert(),
                                                    message: error.localizedDescription.description,
                                                    preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
