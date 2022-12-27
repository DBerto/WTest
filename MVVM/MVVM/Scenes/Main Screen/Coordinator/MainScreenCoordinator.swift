//
//  MainScreenCoordinator.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol MainScreenCoordinatorProtocol: BaseCoordinator {
    func perform(_ action: MainScreenCoordinator.Action)
}

final class MainScreenCoordinator: BaseCoordinator,
                                   MainScreenCoordinatorProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let vc = MainScreenBuilder().setup(coordinator: self)
        viewController = vc
        push(viewController: viewController,
             from: navigationController)
    }
    
    func perform(_ action: Action) {
        switch action {
        case .showPostalCodes:
            coordinateToPostalCodes()
        case .error(let error):
            showError(error,
                      from: viewController)
        }
    }
    
    private func coordinateToPostalCodes() {
        let postalCodesCoordinator: PostalCodesCoordinator = .init(navigationController: navigationController)
        coordinate(to: postalCodesCoordinator)
    }
}

extension MainScreenCoordinator {
    enum Action {
        case showPostalCodes
        case error(_ error: Error)
    }
}
