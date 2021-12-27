//
//  MainScreenCoordinator.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol MainScreenCoordinatorType: Coordinator, BaseCoordinator {
    var viewController: BaseViewController { get }
    func perform(_ action: MainScreenCoordinator.Action)
}

final class MainScreenCoordinator: BaseCoordinator, MainScreenCoordinatorType {
    private(set) unowned var viewController: BaseViewController
    
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    func perform(_ action: Action) {
        switch action {
        case .error(let error):
            showError(error, from: viewController)
        }
    }
}

extension MainScreenCoordinator {
    enum Action {
        case error(_ error: Error)
    }
}
