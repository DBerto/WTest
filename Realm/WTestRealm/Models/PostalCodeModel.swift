//
//  PostalCodeModel.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PostalCodeModel: Object {
    dynamic var local: String?
    dynamic var number: String?
}
