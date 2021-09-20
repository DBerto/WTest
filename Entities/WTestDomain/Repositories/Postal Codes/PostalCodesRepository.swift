//
//  PostalCodesStorageRepositoryInterface.swift
//  WTestDomain
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestRealm

public protocol PostalCodesRepositoryType {
    func savePostalCode(_ postalCode: PostalCode) -> Result<Void, Error>
    func savePostalCodes(_ postalCode: [PostalCode]) -> Result<Void, Error>
    func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> Result<[PostalCode], Error>
}

public class PostalCodesRepository: PostalCodesRepositoryType {
    private let storageRepository: PostalCodesStorageRepositoryType
    
    public init(storageRepository: PostalCodesStorageRepositoryType) {
        self.storageRepository = storageRepository
    }
    
    public func savePostalCode(_ postalCode: PostalCode) -> Result<Void, Error> {
        storageRepository.savePostalCode(postalCode.asPostalCodeDB())
    }
    
    public func savePostalCodes(_ postalCode: [PostalCode]) -> Result<Void, Error> {
        storageRepository.savePostalCodes(postalCode.compactMap { $0.asPostalCodeDB()})
    }
    
    public func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> Result<[PostalCode], Error> {
        let result = storageRepository.fetchPostalCodes(withPredicate: predicate)
        switch result {
        case .success(let postalCodesDB):
            return .success(postalCodesDB.compactMap { $0.asPostalCode() })
        case .failure(let error):
            return .failure(error)
        }
    }
}
