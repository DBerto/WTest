//
//  LoadingScreenCoordinator.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol LoadingScreenCoordinatorType: Coordinator, BaseCoordinator {
    var viewController: BaseViewController { get }
    func perform(_ action: LoadingScreenCoordinator.Action)
}

final class LoadingScreenCoordinator: BaseCoordinator, LoadingScreenCoordinatorType {
    private(set) unowned var viewController: BaseViewController
    
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    func perform(_ action: Action) {
        switch action {
        case .showMainScreen:
            let vc = MainScreenBuilder().setup()            
            push(viewController: vc,
                 from: viewController,
                 animated: true)
        case .error(let error):
            showError(error, from: viewController)
        }
    }
}

extension LoadingScreenCoordinator {
    enum Action {
        case error(_ error: Error)
        case showMainScreen
    }
}
