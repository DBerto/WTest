//
//  Repository.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

protocol IRepository {
    associatedtype EntityObject: Entity
    
    func getAll(where predicate: NSPredicate?) -> [EntityObject]
    func insert(item: EntityObject) throws
    func insertMany(items: [EntityObject]) throws    
    func update(item: EntityObject) throws
    func delete(item: EntityObject) throws
}

extension IRepository {
    func getAll() -> [EntityObject] {
        return getAll(where: nil)
    }
}
