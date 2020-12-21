//
//  PostalCodes.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

// MARK: Navigation Layer

protocol PostalCodesWireframeInterface: WireframeInterface {

}

// MARK: User Interface Layer

protocol PostalCodesViewInterface: ViewInterface {
    func updateView(with viewModel: PostalCodesViewModel)
    func updateLoadingIndicator(_ value: Bool)
}

protocol PostalCodesEventHandler: class {
    func viewIsLoaded()
}

// MARK: Business Layer

protocol PostalCodesInteractorInterface: class {
    func fetchPostalCodes()
}

protocol PostalCodesPresenterInterface: class {
    func fetchPostalCodesFailed(_ error: Error)
    func fetchPostalCodesSucceed(_ postalCodes: [PostalCode])
}
