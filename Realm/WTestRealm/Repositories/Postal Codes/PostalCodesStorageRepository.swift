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
    func savePostalCode(_ postalCode: PostalCodeDB) -> Result<Void, Error>
    func savePostalCodes(_ postalCodes: [PostalCodeDB]) -> Result<Void, Error>
    func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> Result<[PostalCodeDB], Error>
}

public final class PostalCodesStorageRepository: BaseStorageRepository, PostalCodesStorageRepositoryType {
    
    public func savePostalCodes(_ postalCodes: [PostalCodeDB]) -> Result<Void, Error> {
        let realm = self.realm
        do {
            try realm.write {
                realm.add(postalCodes)
            }
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    public func savePostalCode(_ postalCode: PostalCodeDB) -> Result<Void, Error> {
        let realm = self.realm
        do {
            try realm.write {
                realm.add(postalCode)
            }
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    public func fetchPostalCodes(withPredicate predicate: NSPredicate?) -> Result<[PostalCodeDB], Error>{
        let realm = self.realm
        var objects = realm.objects(PostalCodeDB.self)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        let postalCodes = Array(objects)
        return .success(postalCodes)
    }
    
}
