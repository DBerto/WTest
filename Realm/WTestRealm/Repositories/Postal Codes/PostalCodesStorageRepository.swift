//
//  PostalCodesStorageRepository.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestCommon
import RealmSwift
import Combine

public protocol PostalCodesStorageRepositoryType {
    func savePostalCode(_ postalCode: PostalCodeDB) -> Future<Void, Error>
    func savePostalCodes(_ postalCodes: [PostalCodeDB]) -> Future<Void, Error>
    func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> Future<[PostalCodeDB], Error>
}

public final class PostalCodesStorageRepository: BaseStorageRepository, PostalCodesStorageRepositoryType {
    private var token: NotificationToken?
    
    public func savePostalCodes(_ postalCodes: [PostalCodeDB]) -> Future<Void, Error> {
        return Future<Void, Error> { promisse in
            let realm = self.realm
            do {
                try realm.write {
                    realm.add(postalCodes)
                }
                return promisse(.success(()))
            } catch {
                return promisse(.failure(error))
            }
        }
    }
    
    public func savePostalCode(_ postalCode: PostalCodeDB) -> Future<Void, Error> {
        return Future<Void, Error> { promisse in
            let realm = self.realm
            do {
                try realm.write {
                    realm.add(postalCode)
                }
                return promisse(.success(()))
            } catch {
                return promisse(.failure(error))
            }
        }
    }
    
    public func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> Future<[PostalCodeDB], Error> {
        return Future<[PostalCodeDB], Error> { promisse in
            let realm = self.realm
            var objects = realm.objects(PostalCodeDB.self)
            
            if let predicate = predicate {
                objects = objects.filter(predicate)
            }
            
            self.token = objects.observe(on: .main) { changes in
                switch changes {
                case .initial(let collection):
                    promisse(.success(Array(collection)))
                case .update: break
                case .error(let error):
                    promisse(.failure(error))
                }
            }
        }
    }
}
