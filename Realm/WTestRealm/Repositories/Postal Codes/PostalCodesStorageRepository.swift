//
//  PostalCodesStorageRepository.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import RealmSwift

public protocol PostalCodesStorageRepositoryType {
    func savePostalCode(_ postalCode: PostalCodeDB,
                        completion: @escaping (Result<Void, Error>) -> Void)
    func savePostalCodes(_ postalCode: [PostalCodeDB],
                         completion: @escaping (Result<Void, Error>) -> Void)
    func fetchPostalCodes(withPredicate predicate: NSPredicate?,
                          completion: @escaping (Result<[PostalCodeDB], Error>) -> Void)
}

public final class PostalCodesStorageRepository: BaseStorageRepository, PostalCodesStorageRepositoryType {
    
    public func savePostalCodes(_ postalCode: [PostalCodeDB],
                                completion: @escaping (Result<Void, Error>) -> Void) {
        let realm = self.realm
        do {
            try realm.write {
                let objects = postalCode.map({ $0 })
                realm.add(objects)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func savePostalCode(_ postalCode: PostalCodeDB,
                               completion: @escaping (Result<Void, Error>) -> Void) {
        let realm = self.realm
        do {
            try realm.write {
                let model = postalCode
                realm.add(model)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func fetchPostalCodes(withPredicate predicate: NSPredicate?,
                                 completion: @escaping (Result<[PostalCodeDB], Error>) -> Void) {
        let realm = self.realm
        var objects = realm.objects(PostalCodeDB.self)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        let postalCodes = Array(objects)
        completion(.success(postalCodes))
    }
    
}
