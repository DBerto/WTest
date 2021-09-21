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

protocol LoadingScreenBuilderType {
    func setup() -> LoadingScreenViewControllerType
}

class LoadingScreenBuilder: LoadingScreenBuilderType {
    func setup() -> LoadingScreenViewControllerType {
        let storageRepository = PostalCodesStorageRepository()
        let remoteRepository = PostalCodesRemoteRepository()
        let repository = PostalCodesRepository(storageRepository: storageRepository,
                                               remoteRepository: remoteRepository)
        let useCase = PostalCodeUseCase(repository: repository)
        let vm = LoadingScreenViewModel(postalCodeUseCase: useCase)
        let vc = LoadingScreenViewController()
        vc.viewModel = vm        
        return vc
    }
}
