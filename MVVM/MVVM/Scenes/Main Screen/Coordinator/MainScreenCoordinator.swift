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
        case .showPostalCodes:
            showPostalCodes()
        case .error(let error):
            showError(error, from: viewController)
        }
    }
    
    private func showPostalCodes() {
        let vc = PostalCodesBuilder().setup()
        push(viewController: vc,
             from: viewController,
             animated: true)
    }
}

extension MainScreenCoordinator {
    enum Action {
        case showPostalCodes
        case error(_ error: Error)
    }
}
