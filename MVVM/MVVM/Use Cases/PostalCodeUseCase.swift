//
//  PostalCodeUseCase.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 08/01/2021.
//

import Foundation
import WTestCommon
import WTestDomain

protocol PostalCodeUseCaseType: class {
    func fetchPostalCodes(completion: @escaping (Result<[PostalCode], Error>) -> Void)
}

class PostalCodeUseCase: PostalCodeUseCaseType {
    
    private let repository: PostalCodesRepositoryType
    
    init(repository: PostalCodesRepositoryType) {
        self.repository = repository
    }
    
    func fetchPostalCodes(completion: @escaping (Result<[PostalCode], Error>) -> Void) {

    }
}
