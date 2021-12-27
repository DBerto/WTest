//
//  Coordinator.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import UIKit

protocol Coordinator {    
    var cancelBag: CancellableBag { get set }
}

protocol BaseCoordinatorType: AnyObject { }

class BaseCoordinator: BaseCoordinatorType {
    var cancelBag: CancellableBag = .init()
    
    private func present(viewController: BaseViewController,
                         from: BaseViewController?,
                         animated: Bool) {
        from?.present(viewController, animated: animated, completion: nil)
    }
    
    func push(viewController: BaseViewController,
              from: BaseViewController?,
              animated: Bool) {
        if let navigationController = from?.navigationController {
            navigationController.pushViewController(viewController, animated: animated)
        } else {
            present(viewController: viewController, from: from, animated: animated)
        }
    }
    
    func pop(viewController: BaseViewController?, animated: Bool) {
        if let navigationController = viewController?.navigationController {
            navigationController.popViewController(animated: animated)
        } else{
            viewController?.dismiss(animated: animated, completion: nil)
        }
    }
    
    func dismiss(viewController: BaseViewController?,
                 animated: Bool,
                 isLoading: Bool = false) {
        if let navigationController = viewController?.navigationController,
           !isLoading {
            navigationController.popViewController(animated: animated)
        } else {
            viewController?.dismiss(animated: animated, completion: nil)
        }
    }
    
    func showAlert(with title: String? = nil,
                   message: String? = nil,
                   from viewController: BaseViewController?) {
        viewController?.showAlert(with: title,
                                  message: message)
    }
    
    func showError(_ error: Error,
                   from viewController: BaseViewController?) {
        viewController?.showError(error)
    }
}
