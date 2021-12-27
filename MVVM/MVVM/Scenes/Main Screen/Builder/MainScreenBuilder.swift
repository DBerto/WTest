//
//  MainScreenBuilder.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation

protocol MainScreenBuilderType: AnyObject {
    func setup() -> MainScreenViewControllerType
}

class MainScreenBuilder: MainScreenBuilderType {
    func setup() -> MainScreenViewControllerType {
        let vc = MainScreenViewController()
        vc.navigationItem.hidesBackButton = true
        let coordinator = MainScreenCoordinator(viewController: vc)
        let viewModel = MainScreenViewModel(coordinator: coordinator)
        vc.viewModel = viewModel
        return vc
    }
}
