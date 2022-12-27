//
//  AppCoordinator.swift
//  MVVM
//
//  Created by Berto, David Manuel  on 27/12/2022.
//

import Foundation
import UIKit
import WTestCommon

class AppCoordinator: BaseCoordinator {
    @UserDefault(key: "isAppAlreadyLaunched", defaultValue: false)
    var isAppAlreadyLaunched: Bool
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let navController = UINavigationController()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        let mainScreenCoordinator: MainScreenCoordinator = .init(navigationController: navController)
        let loadingScreenCoordinator: LoadingScreenCoordinator = .init(navigationController: navController)
        let mainCoordinator: CoordinatorProtocol = isAppAlreadyLaunched ? mainScreenCoordinator : loadingScreenCoordinator
        coordinate(to: mainCoordinator)
    }
}
