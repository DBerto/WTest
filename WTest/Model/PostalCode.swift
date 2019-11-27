//
//  PostalCode.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

class PostalCode: Hashable {
    let numCodPostal: String
    let extCodPostal: String
    let desigPostal: String
    
    internal init(numCodPostal: String, extCodPostal: String, desigPostal: String) {
        self.numCodPostal = numCodPostal
        self.extCodPostal = extCodPostal
        self.desigPostal = desigPostal
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(numCodPostal)
        hasher.combine(extCodPostal)
        hasher.combine(desigPostal)
    }
    
    static func == (lhs: PostalCode, rhs: PostalCode) -> Bool {
        return lhs.numCodPostal == rhs.numCodPostal &&
            lhs.extCodPostal == rhs.extCodPostal &&
            lhs.desigPostal == rhs.desigPostal
    }
}

extension PostalCode: Entity {
    private var storablePostalCode: StorablePostalCode {
        let realmPostalCode = StorablePostalCode()
        realmPostalCode.numCodPostal = numCodPostal
        realmPostalCode.extCodPostal = extCodPostal
        realmPostalCode.desigPostal = desigPostal
        realmPostalCode.uuid = numCodPostal+"-"+extCodPostal+"-"+desigPostal.replacingOccurrences(of: "'", with: "-")
        return realmPostalCode
    }
    
    func toStorable() -> StorablePostalCode {
        return storablePostalCode
    }
}
