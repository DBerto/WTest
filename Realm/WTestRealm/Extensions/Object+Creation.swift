//
//  Object+Creation.swift
//  WTestRealm
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import RealmSwift
import Foundation

public extension Object {
    static func create<T: Object>(_ builder: (T) -> Void) -> T {
        let object = T()
        builder(object)
        return object
    }
}
