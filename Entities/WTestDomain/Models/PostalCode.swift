//
//  PostalCode.swift
//  Entities
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

public struct PostalCode {
    public let local: String
    public let number: String
    
    public init(local: String, number: String) {
        self.local = local
        self.number = number
    }
}
