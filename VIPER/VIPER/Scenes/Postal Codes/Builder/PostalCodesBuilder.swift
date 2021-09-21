//
//  PostalCodesBuilder.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain
import WTestRealm
import WTestAPI

class PostalCodesBuilder {
    
    func makeModule() -> PostalCodesWireframe {
        let view = makeView()
        let interactor = makeInteractor()
        let presenter = makePresenter()
        let wireframe = makeWireframe(view: view, interactor: interactor, presenter: presenter)
        
        connect(view: view, interactor: interactor, presenter: presenter, wireframe: wireframe)
        configure(presenter: presenter, interactor: interactor)
        
        return wireframe
    }
    
    private func makeView() -> PostalCodesViewController {
        PostalCodesViewController()
    }
    
    private func makeInteractor() -> PostalCodesInteractor {
        PostalCodesInteractor(repository: PostalCodesRepository(storageRepository: PostalCodesStorageRepository(),
                                                                remoteRepository: PostalCodesRemoteRepository()))
    }
    
    private func makePresenter() -> PostalCodesPresenter {
        PostalCodesPresenter()
    }
    
    private func makeWireframe(view: PostalCodesViewController, interactor: PostalCodesInteractor,
                               presenter: PostalCodesPresenter) -> PostalCodesWireframe {
        PostalCodesWireframe(view: view, interactor: interactor, presenter: presenter)
    }
    
    private func connect(view: PostalCodesViewController, interactor: PostalCodesInteractor,
                         presenter: PostalCodesPresenter, wireframe: PostalCodesWireframe) {
        presenter.wireframe = wireframe
        presenter.view = view
        presenter.interactor = interactor
        view.eventHandler = presenter
        interactor.presenter = presenter
    }
    
    private func configure(presenter: PostalCodesPresenter, interactor: PostalCodesInteractor) {
        
    }
}
