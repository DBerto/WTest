//
//  BaseStorageRepository.swift
//  Realm
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import RealmSwift

public class BaseStorageRepository {
    let configuration: Realm.Configuration
    
    var realm: Realm {
        do {
            return try Realm(configuration: self.configuration)
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
    
    public init(configuration: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        var configuration = configuration
        configuration.deleteRealmIfMigrationNeeded = true
        self.configuration = configuration
    }
}
