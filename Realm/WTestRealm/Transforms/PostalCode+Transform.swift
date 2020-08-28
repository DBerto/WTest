//
//  PostalCode+Transform.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestDomain

internal extension PostalCode {
    func asPostalCodeModel() -> PostalCodeModel {
        return PostalCodeModel.create { (object) in
            object.local = local
            object.number = number
        }
    }
}

internal extension PostalCodeModel {
    func asPostalCode() -> PostalCode {
        return PostalCode(local: local ?? "", number: number ?? "")
    }
}
