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

enum PostalCodeUseCaseError: LocalizedError {
    case appAlreadyLaunched
    
    public var errorDescription: String? {
        switch self {
        case .appAlreadyLaunched:
            return "appAlreadyLaunched"
        }
    }
}

protocol PostalCodeUseCaseType: class {
    func downloadPostalCodes() -> Result<[PostalCode], Error>
}

class PostalCodeUseCase: PostalCodeUseCaseType {
    private let repository: PostalCodesRepositoryType
    
    @UserDefault(key: "isAppAlreadyLaunched", defaultValue: false)
    var isAppAlreadyLaunched: Bool
    
    init(repository: PostalCodesRepositoryType) {
        self.repository = repository
    }
    
    func downloadPostalCodes() -> Result<[PostalCode], Error> {
        guard isAppAlreadyLaunched == false else { return .failure(PostalCodeUseCaseError.appAlreadyLaunched) }
        return repository.downloadPostalCodes()
    }
    
    func savePostalCodes(_ postalCodes: [PostalCode]) -> Result<Void, Error> {
        isAppAlreadyLaunched = true
        return repository.savePostalCodes(postalCodes)
    }
}
