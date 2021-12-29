//
//  PostalCodesCoordinator.swift
//  MVVM
//
//  Created by David Berto on 29/12/2021.
//

import Foundation
import UIKit
import WTestCommon

protocol PostalCodesCoordinatorType: Coordinator, BaseCoordinator {
    var viewController: BaseViewController { get }
    func perform(_ action: PostalCodesCoordinator.Action)
}

final class PostalCodesCoordinator: BaseCoordinator, PostalCodesCoordinatorType {
    private(set) unowned var viewController: BaseViewController
    
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    func perform(_ action: Action) { }
}

extension PostalCodesCoordinator {
    enum Action { }
}
