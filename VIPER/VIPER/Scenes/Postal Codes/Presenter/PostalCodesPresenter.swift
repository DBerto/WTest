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
        view.updateLoadingIndicator(true)
        executeInBackgroundThread { [weak self] in
            self?.interactor.fetchPostalCodes()
        }
    }
    
    func searchRequest(withText text: String) {
        view.updateLoadingIndicator(true)
        view.updateView(with: PostalCodesViewModel(postalCodes: []))
        executeInBackgroundThread { [weak self] in
            self?.interactor.searchPotalCodes(withText: text)
        }
    }
    
    // MARK: - PostalCodesInteractorInterface
    
    func fetchPostalCodesFailed(_ error: Error) {
        view.showError(error)
    }
    
    func fetchPostalCodesSucceed(_ postalCodes: [PostalCode]) {
        let postalCodes = postalCodes.map { PostalCodeViewModel(local: $0.local, number: $0.number) }
        view.updateView(with: PostalCodesViewModel(postalCodes: postalCodes))
        view.updateLoadingIndicator(false)
    }
    
}
