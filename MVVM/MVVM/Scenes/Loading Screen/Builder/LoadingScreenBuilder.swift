//
//  LoadingScreenBuilder.swift
//  MVVM
//
//  Created by David Berto on 22/09/2021.
//

import Foundation
import WTestDomain
import WTestRealm
import WTestAPI

protocol LoadingScreenBuilderType: AnyObject {
    func setup(coordinator: LoadingScreenCoordinator) -> LoadingScreenViewControllerProtocol
}

class LoadingScreenBuilder: LoadingScreenBuilderType {
    func setup(coordinator: LoadingScreenCoordinator) -> LoadingScreenViewControllerProtocol {
        let storageRepository = PostalCodesStorageRepository()
        let remoteRepository = PostalCodesRemoteRepository()
        let repository = PostalCodesRepository(storageRepository: storageRepository,
                                               remoteRepository: remoteRepository)
        let useCase = PostalCodeUseCase(repository: repository)
        let proxyUseCase = ProxyPostalCodeUseCase(useCase: useCase)
        let vc = LoadingScreenViewController()
        let vm = LoadingScreenViewModel(proxyPostalCodeUseCase: proxyUseCase,
                                        coordinator: coordinator)
        vc.viewModel = vm        
        return vc
    }
}
