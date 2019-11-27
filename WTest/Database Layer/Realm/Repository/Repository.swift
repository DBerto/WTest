//
//  Repository.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import RealmSwift

class Repository<RepositoryObject>: IRepository
    where RepositoryObject: Entity,
RepositoryObject.StoreType: Object {
    
    typealias RealmObject = RepositoryObject.StoreType
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getAll(where predicate: NSPredicate?) -> [RepositoryObject] {
        var objects = realm.objects(RealmObject.self)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        return objects.compactMap{ ($0).model as? RepositoryObject }
    }
    
    func insert(item: RepositoryObject) throws {
        try realm.write {
            if(!exists(pk: item.toStorable().uuid)){
                realm.add(item.toStorable())
            }
        }
    }
    
    // Realm performance improvement
    func insertMany(items: [RepositoryObject]) throws {
        try realm.write {
            for item in items {
                if(!exists(pk: item.toStorable().uuid)){
                    realm.add(item.toStorable())
                }
            }
        }
    }
    
    func update(item: RepositoryObject) throws {
        try delete(item: item)
        try insert(item: item)
    }
    
    func delete(item: RepositoryObject) throws {
        try realm.write {
            let predicate = NSPredicate(format: "uuid == %@", item.toStorable().uuid)
            if let productToDelete = realm.objects(RealmObject.self)
                .filter(predicate).first {
                realm.delete(productToDelete)
            }
        }
    }
    
    private func exists(pk: String) -> Bool{
        return !getAll(where: NSPredicate(format: "uuid == '\(pk)'")).isEmpty
    }
}
