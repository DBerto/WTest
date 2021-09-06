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
    func savePostalCode(_ postalCode: PostalCode,
                        completion: @escaping (Result<Void, Error>) -> Void)
    func savePostalCodes(_ postalCode: [PostalCode],
                         completion: @escaping (Result<Void, Error>) -> Void)
    func fetchPostalCodes(withPredicate predicate: NSPredicate?,
                          completion: @escaping (Result<[PostalCode], Error>) -> Void)
}

public class PostalCodesRepository: PostalCodesRepositoryType {
    private let storageRepository: PostalCodesStorageRepositoryType
    
    public init(storageRepository: PostalCodesStorageRepositoryType) {
        self.storageRepository = storageRepository
    }
    
    public func savePostalCode(_ postalCode: PostalCode,
                        completion: @escaping (Result<Void, Error>) -> Void) {
        storageRepository.savePostalCode(postalCode.asPostalCodeDB(),
                                         completion: completion)
    }
    
    public func savePostalCodes(_ postalCode: [PostalCode],
                         completion: @escaping (Result<Void, Error>) -> Void) {
        storageRepository.savePostalCodes(postalCode.compactMap { $0.asPostalCodeDB()},
                                          completion: completion)
    }
    
    public func fetchPostalCodes(withPredicate predicate: NSPredicate?,
                          completion: @escaping (Result<[PostalCode], Error>) -> Void) {
        
        storageRepository.fetchPostalCodes(withPredicate: predicate) { result in
            if case let Result.success(postalCodesDB) = result {
                completion(.success(postalCodesDB.compactMap { $0.asPostalCode() }))
            }
        }
    }
}
