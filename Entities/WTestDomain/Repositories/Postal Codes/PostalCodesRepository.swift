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

public protocol PostalCodesRepositoryType {
    func savePostalCode(_ postalCode: PostalCode) -> ObservableType<Void>
    func savePostalCodes(_ postalCode: [PostalCode]) -> ObservableType<Void>
    func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> ObservableType<[PostalCode]>
    func downloadPostalCodes() -> ObservableType<[PostalCode]>
}

public class PostalCodesRepository: PostalCodesRepositoryType {
    private let storageRepository: PostalCodesStorageRepositoryType
    private let remoteRepository: PostalCodesRemoteRepositoryType
    
    public init(storageRepository: PostalCodesStorageRepositoryType,
                remoteRepository: PostalCodesRemoteRepositoryType) {
        self.storageRepository = storageRepository
        self.remoteRepository = remoteRepository
    }
    
    public func savePostalCode(_ postalCode: PostalCode) -> ObservableType<Void> {
        storageRepository.savePostalCode(postalCode.asPostalCodeDB()).asObservable()
    }
    
    public func savePostalCodes(_ postalCode: [PostalCode]) -> ObservableType<Void> {
        storageRepository.savePostalCodes(postalCode.compactMap { $0.asPostalCodeDB()}).asObservable()
    }
    
    public func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> ObservableType<[PostalCode]> {
        storageRepository.fetchPostalCodes(withPredicate: predicate)
            .compactMap {
                $0.asPostalCodeArray()
            }.asObservable()
    }
    
    public func downloadPostalCodes() -> ObservableType<[PostalCode]> {
        remoteRepository.downloadPostalCodes()
            .compactMap {
                $0.asPostalCodeArray()
            }.asObservable()
    }
}
