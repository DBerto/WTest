//
//  PostalCodeUseCase.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import WTestDomain
import Combine

protocol PostalCodeUseCaseType: class {
    func fetchPostalCodes() -> Result<[PostalCode], Error>
}

class PostalCodeUseCase: PostalCodeUseCaseType {
    
    private let repository: PostalCodesRepositoryType
    
    init(repository: PostalCodesRepositoryType) {
        self.repository = repository
    }
    
    func fetchPostalCodes() -> Result<[PostalCode], Error> {
        repository.fetchPostalCodes(withPredicate: nil)
    }
    
    func savePostalCodes(_ postalCodes: [PostalCode]) -> Result<Void, Error> {
        repository.savePostalCodes(postalCodes)
    }
}
