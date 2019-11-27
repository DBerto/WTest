//
//  StorablePostalCode.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import RealmSwift

class StorablePostalCode: Object, Storable {
    
    @objc dynamic var numCodPostal: String = ""
    @objc dynamic var extCodPostal: String = ""
    @objc dynamic var desigPostal: String = ""
    @objc dynamic var uuid: String = ""
    
    override class func primaryKey() -> String? {
           return "uuid"
       }
    
    var model: PostalCode
    {
        get {
            return PostalCode(numCodPostal: numCodPostal, extCodPostal: extCodPostal,
                              desigPostal: desigPostal)
        }
    }
}
