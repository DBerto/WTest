//
//  LoadingScreenCoordinator.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol LoadingScreenCoordinatorProtocol: BaseCoordinator {
    func perform(_ action: LoadingScreenCoordinator.Action)
}

final class LoadingScreenCoordinator: BaseCoordinator,
                                      LoadingScreenCoordinatorProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let vc = LoadingScreenBuilder().setup(coordinator: self)
        viewController = vc
        push(viewController: viewController,
             from: navigationController)
    }
    
    func perform(_ action: Action) {
        switch action {
        case .showMainScreen:
            coordinateToMainScreen()
        case .error(let error):
            showError(error,
                      from: viewController)
        }
    }
    
    private func coordinateToMainScreen() {
        let mainScreenCoordinator: MainScreenCoordinator = .init(navigationController: navigationController)
        coordinate(to: mainScreenCoordinator)
    }
}

extension LoadingScreenCoordinator {
    enum Action {
        case error(_ error: Error)
        case showMainScreen
    }
}
