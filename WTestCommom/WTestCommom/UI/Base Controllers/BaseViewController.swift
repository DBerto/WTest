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
    
    public let lifecycle: ViewLifecycle = .init()
    
    deinit {
        lifecycle.trigger(.deinitialize)
        print("deinit")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        lifecycle.trigger(.viewDidLoad)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lifecycle.trigger(.viewWillAppear)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lifecycle.trigger(.viewDidAppear)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        lifecycle.trigger(.viewWillDisappear)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        lifecycle.trigger(.viewDidDisappear)
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
