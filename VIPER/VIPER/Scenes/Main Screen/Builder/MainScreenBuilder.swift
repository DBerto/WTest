//
//  MainScreenBuilder.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestRealm

class MainScreenBuilder {

    func makeModule() -> MainScreenWireframe {
        let view = makeView()
        let interactor = makeInteractor()
        let presenter = makePresenter()
        let wireframe = makeWireframe(view: view, interactor: interactor, presenter: presenter)

        connect(view: view, interactor: interactor, presenter: presenter, wireframe: wireframe)
        configure(presenter: presenter, interactor: interactor)

        return wireframe
    }

    private func makeView() -> MainScreenViewController {
        MainScreenViewController()
    }

    private func makeInteractor() -> MainScreenInteractor {
        MainScreenInteractor()
    }

    private func makePresenter() -> MainScreenPresenter {
        MainScreenPresenter()
    }

    private func makeWireframe(view: MainScreenViewController, interactor: MainScreenInteractor,
                               presenter: MainScreenPresenter) -> MainScreenWireframe {
        MainScreenWireframe(view: view, interactor: interactor, presenter: presenter)
    }

    private func connect(view: MainScreenViewController, interactor: MainScreenInteractor,
                         presenter: MainScreenPresenter, wireframe: MainScreenWireframe) {
        presenter.wireframe = wireframe
        presenter.view = view
        presenter.interactor = interactor
        view.eventHandler = presenter
        interactor.presenter = presenter
    }

    private func configure(presenter: MainScreenPresenter, interactor: MainScreenInteractor) {

    }
}
