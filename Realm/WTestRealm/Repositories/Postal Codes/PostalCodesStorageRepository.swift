//
//  PostalCodesStorageRepository.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import RealmSwift
import WTestDomain

public final class PostalCodesStorageRepository: BaseStorageRepository, PostalCodesStorageRepositoryInterface {
    
    public func savePostalCodes(_ postalCode: [PostalCode], completion: @escaping (Result<Void, Error>) -> Void) {
        let realm = self.realm
        do {
            try realm.write {
                let objects = postalCode.map({ $0.asPostalCodeModel() })
                realm.add(objects)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func savePostalCode(_ postalCode: PostalCode, completion: @escaping (Result<Void, Error>) -> Void) {
        let realm = self.realm
        do {
            try realm.write {
                let model = postalCode.asPostalCodeModel()
                realm.add(model)
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    public func fetchPostalCodes(completion: @escaping (Result<[PostalCode], Error>) -> Void) {
        let realm = self.realm
        let objects = realm.objects(PostalCodeModel.self)
        let postalCodes = Array(objects.map { $0.asPostalCode() })
        completion(.success(postalCodes))
    }
    
}
