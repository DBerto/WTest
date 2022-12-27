//
//  MainScreenBuilder.swift
//  MVVM
//
//  Created by David Berto on 27/12/2021.
//

import Foundation

protocol MainScreenBuilderType: AnyObject {
    func setup(coordinator: MainScreenCoordinator) -> MainScreenViewControllerProtocol
}

class MainScreenBuilder: MainScreenBuilderType {
    func setup(coordinator: MainScreenCoordinator) -> MainScreenViewControllerProtocol {
        let vc = MainScreenViewController()
        vc.navigationItem.hidesBackButton = true
        let viewModel = MainScreenViewModel(coordinator: coordinator)
        vc.viewModel = viewModel
        return vc
    }
}
