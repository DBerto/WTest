//
//  PostalCodesInteractorInterface.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

class PostalCodesInteractor: PostalCodesInteractorInterface {
    
    weak var presenter: PostalCodesPresenterInterface!
    let databaseRepository: PostalCodesStorageRepositoryInterface!
    
    init(databaseRepository: PostalCodesStorageRepositoryInterface) {
        self.databaseRepository = databaseRepository
    }
    
    func fetchPostalCodes() {
        databaseRepository.fetchPostalCodes { [weak self] (result) in
            switch result {
            case .success(let postalCodes):
                self?.presenter.fetchPostalCodesSucceed(postalCodes)
            case .failure(let error):
                self?.presenter.fetchPostalCodesFailed(error)
            }
        }
    }
    
}
