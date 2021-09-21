//
//  LoadingScreenBuilder.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 25/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain
import WTestRealm
import WTestAPI

class LoadingScreenBuilder {

    func makeModule() -> LoadingScreenWireframe {
        let view = makeView()
        let interactor = makeInteractor()
        let presenter = makePresenter()
        let wireframe = makeWireframe(view: view, interactor: interactor, presenter: presenter)

        connect(view: view, interactor: interactor, presenter: presenter, wireframe: wireframe)
        configure(presenter: presenter, interactor: interactor)

        return wireframe
    }

    private func makeView() -> LoadingScreenViewController {
        LoadingScreenViewController()
    }

    private func makeInteractor() -> LoadingScreenInteractor {
        LoadingScreenInteractor(repository: PostalCodesRepository(storageRepository: PostalCodesStorageRepository(),
                                                                  remoteRepository: PostalCodesRemoteRepository()))
    }

    private func makePresenter() -> LoadingScreenPresenter {
        LoadingScreenPresenter()
    }

    private func makeWireframe(view: LoadingScreenViewController, interactor: LoadingScreenInteractor,
                               presenter: LoadingScreenPresenter) -> LoadingScreenWireframe {
        LoadingScreenWireframe(view: view, interactor: interactor, presenter: presenter)
    }

    private func connect(view: LoadingScreenViewController, interactor: LoadingScreenInteractor,
                         presenter: LoadingScreenPresenter, wireframe: LoadingScreenWireframe) {
        presenter.wireframe = wireframe
        presenter.view = view
        presenter.interactor = interactor
        view.eventHandler = presenter
        interactor.presenter = presenter
    }

    private func configure(presenter: LoadingScreenPresenter, interactor: LoadingScreenInteractor) {

    }
}
