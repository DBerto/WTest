//
//  BaseViewController.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func showAlert(with title: String? = nil, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: R.string.localizable.alert(),
                                                message: error.localizedDescription.description,
                                                preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
}
