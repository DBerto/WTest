//
//  PostalCode+Transform.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestRealm
import WTestAPI

extension PostalCode {
    func asPostalCodeDB() -> PostalCodeDB {
        PostalCodeDB.create { (object) in
            object.local = local
            object.number = number
        }
    }
}

extension Sequence where Element == PostalCode {
    func asPostalCodeDBArray() -> [PostalCodeDB] {
        return self.map { $0.asPostalCodeDB() }
    }
}

extension PostalCodeDB {
    func asPostalCode() -> PostalCode {
        PostalCode(local: local ?? "",
                   number: number ?? "")
    }
}

extension Sequence where Element == PostalCodeDB {
    func asPostalCodeArray() -> [PostalCode] {
        return self.map { $0.asPostalCode() }
    }
}

extension PostalCodeResponse {
    func asPostalCode() -> PostalCode {
        let numCodPostal: String = self.numCodPostal ?? ""
        let extCodPostal: String = self.extCodPostal ?? ""
        let nomeLocalidade: String = self.nomeLocalidade ?? ""
        let number: String = numCodPostal + " - " + extCodPostal
        
        return .init(local: nomeLocalidade,
                     number: number)
    }
}

extension Sequence where Element == PostalCodeResponse {
    func asPostalCodeArray() -> [PostalCode] {
        return self.map { $0.asPostalCode() }
    }
}
