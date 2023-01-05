//
//  PostalCodesStorageRepositoryInterface.swift
//  WTestDomain
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestCommon
import WTestRealm
import WTestAPI
import Combine

public protocol PostalCodesRepositoryProtocol {
    func savePostalCode(_ postalCode: PostalCode) -> ObservableType<Void>
    func savePostalCodes(_ postalCode: [PostalCode]) -> ObservableType<Void>
    func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> ObservableType<[PostalCode]>
    func downloadPostalCodes() async throws -> [PostalCode]
}

public class PostalCodesRepository: PostalCodesRepositoryProtocol {
    private let storageRepository: PostalCodesStorageRepositoryProtocol
    private let remoteRepository: PostalCodesRemoteRepositoryProtocol
    
    public init(storageRepository: PostalCodesStorageRepositoryProtocol,
                remoteRepository: PostalCodesRemoteRepositoryProtocol) {
        self.storageRepository = storageRepository
        self.remoteRepository = remoteRepository
    }
    
    public func savePostalCode(_ postalCode: PostalCode) -> ObservableType<Void> {
        storageRepository.savePostalCode(postalCode.asPostalCodeDB())
            .asObservable()
    }
    
    public func savePostalCodes(_ postalCode: [PostalCode]) -> ObservableType<Void> {
        storageRepository.savePostalCodes(postalCode.compactMap { $0.asPostalCodeDB()})
            .asObservable()
    }
    
    public func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> ObservableType<[PostalCode]> {
        storageRepository.fetchPostalCodes(withPredicate: predicate)
            .compactMap {
                $0.asPostalCodeArray()
            }
            .asObservable()
    }
    
    public func downloadPostalCodes() async throws -> [PostalCode] {
        try await remoteRepository.getPostalCodes()
            .asPostalCodeArray()
    }
}
