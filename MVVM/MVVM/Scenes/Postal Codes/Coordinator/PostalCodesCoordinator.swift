//
//  PostalCodesCoordinator.swift
//  MVVM
//
//  Created by David Berto on 29/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol PostalCodesCoordinatorProtocol: BaseCoordinator {
    func perform(_ action: PostalCodesCoordinator.Action)
}

final class PostalCodesCoordinator: BaseCoordinator,
                                    PostalCodesCoordinatorProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let vc = PostalCodesBuilder().setup(coordinator: self)
        viewController = vc
        push(viewController: viewController,
             from: navigationController)
    }
    
    func perform(_ action: Action) { }
}

extension PostalCodesCoordinator {
    enum Action { }
}
