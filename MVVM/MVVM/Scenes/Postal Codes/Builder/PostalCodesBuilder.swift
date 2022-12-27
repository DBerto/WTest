//
//  PostalCodesBuilder.swift
//  MVVM
//
//  Created by David Berto on 29/12/2021.
//

import Foundation
import WTestDomain
import WTestAPI
import WTestRealm

protocol PostalCodesBuilderType: AnyObject {
    func setup(coordinator: PostalCodesCoordinator) -> PostalCodesViewControllerProtocol
}

class PostalCodesBuilder: PostalCodesBuilderType {
    func setup(coordinator: PostalCodesCoordinator) -> PostalCodesViewControllerProtocol {
        let dataSource = PostalCodesDataSource()
        let dataProvider = PostalCodesDataProvider(dataSource: dataSource)
        let vc = PostalCodesViewController()
        let storageRepository = PostalCodesStorageRepository()
        let remoteRepository = PostalCodesRemoteRepository()
        let repository = PostalCodesRepository(storageRepository: storageRepository,
                                               remoteRepository: remoteRepository)
        let useCase = PostalCodeUseCase(repository: repository)
        let viewModel = PostalCodesViewModel(useCase: useCase,
                                             coordinator: coordinator)
        vc.viewModel = viewModel
        vc.dataProvider = dataProvider
        return vc
    }
}
