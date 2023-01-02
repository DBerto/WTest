//
//  Coordinator.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import UIKit

// https://betterprogramming.pub/implement-coordinator-design-pattern-using-combine-eed5008dafb1

protocol CoordinatorProtocol: AnyObject {
    var viewController: BaseViewController! { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var cancelBag: CancellableBag { get set }
    
    func start()
    func coordinate(to coordinator: CoordinatorProtocol)
}

extension CoordinatorProtocol {
    func coordinate(to coordinator: CoordinatorProtocol) {
        coordinator.start()
        store(coordinator: coordinator)
    }
    
    // MARK: - Private Coordinator Actions
    
    private func store(coordinator: CoordinatorProtocol) {
        coordinator.viewController.lifecycle.deinitializeObs
            .sink { [weak self] _ in
                self?.free(coordinator: coordinator)
            }
            .store(in: cancelBag)
        
        childCoordinators.append(coordinator)
    }
    
    private func free(coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}

class BaseCoordinator: CoordinatorProtocol {
    // MARK: - Protocol vars
    
    unowned var viewController: BaseViewController!
    var childCoordinators: [CoordinatorProtocol] = []
    var cancelBag: CancellableBag = .init()
    
    // MARK: - Start
    
    func start() {
        assertionFailure("Override")
    }
    
    // MARK: - Navigation Actions
    
    func setWindow(_ window: UIWindow,
                   withCoordinator coordinator: CoordinatorProtocol) {
        guard let rootVC = coordinator.viewController else { return }
        window.rootViewController = UINavigationController(rootViewController: rootVC)
        window.makeKeyAndVisible()
        
        childCoordinators.append(coordinator)
    }
    
    func present(viewController: BaseViewController,
                 from: UIViewController?,
                 animated: Bool = true) {
        from?.present(viewController,
                      animated: animated,
                      completion: nil)
    }
    
    func push(viewController: BaseViewController,
              from navController: UINavigationController?,
              animated: Bool = true) {
        navController?.pushViewController(viewController,
                                          animated: animated)
    }
    
    func pop(navController: UINavigationController?,
             animated: Bool = true) {
        navController?.popViewController(animated: animated)
    }
    
    func dismiss(viewController: BaseViewController?,
                 animated: Bool) {
        viewController?.dismiss(animated: animated,
                                completion: nil)
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
