//
//  PostalCodesPresenter.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

class PostalCodesPresenter: PostalCodesEventHandler, PostalCodesPresenterInterface {
    
    // MARK: - Properties
    
    weak var view: PostalCodesViewInterface!
    var wireframe: PostalCodesWireframeInterface!
    var interactor: PostalCodesInteractorInterface!
    
    // MARK: - PostalCodesEventHandler
    
    func viewIsLoaded() {
        DispatchQueue.main.async { [weak self] in
            self?.interactor.fetchPostalCodes()
        }
    }
    
    // MARK: - PostalCodesInteractorInterface
    
    func fetchPostalCodesFailed(_ error: Error) {
        view.showError(error)
    }
    
    func fetchPostalCodesSucceed(_ postalCodes: [PostalCode]) {
        let postalCodes = postalCodes.map { PostalCodeViewModel(local: $0.local, number: $0.number) }
        view.updateView(with: PostalCodesViewModel(postalCodes: postalCodes))
    }
    
}
