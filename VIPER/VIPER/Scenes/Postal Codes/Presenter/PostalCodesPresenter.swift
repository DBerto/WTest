//
//  PostalCodesPresenter.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain
import WTestCommon

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
        view.updateView(with: PostalCodeFieldsViewModel(postalCodeFields: []))
        executeInBackgroundThread { [weak self] in
            self?.interactor.searchPostalCodes(withText: text)
        }
    }
    
    // MARK: - PostalCodesInteractorInterface
    
    func fetchPostalCodesFailed(_ error: Error) {
        view.showError(error)
    }
    
    func fetchPostalCodesSucceed(_ postalCodes: [PostalCode]) {
        let postalCodes = postalCodes.map { PostalCodeFieldViewModel(local: $0.local,
                                                                     number: $0.number) }
        view.updateView(with: PostalCodeFieldsViewModel(postalCodeFields: postalCodes))
        view.updateLoadingIndicator(false)
    }
    
}
