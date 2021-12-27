//
//  BaseViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewInterface: AnyObject {
    func showError(_ error: Error)
}

open class BaseViewController: UIViewController {
    
    // MARK: - Publishers
    
    public var disposeBag: CancellableBag = CancellableBag()
    
    // MARK: - View Cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    public func showAlert(with title: String? = nil, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showError(_ error: Error) {
        let alertController = UIAlertController(title: R.string.localizable.alert(),
                                                message: error.localizedDescription.description,
                                                preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
}
