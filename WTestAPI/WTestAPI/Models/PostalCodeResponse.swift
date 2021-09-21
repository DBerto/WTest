//
//  PostalCodeResponse.swift
//  WTestAPI
//
//  Created by David Berto on 21/09/2021.
//

import Foundation

public struct PostalCodeResponse {
    public let local: String
    public let number: String
    
    public init(local: String, number: String) {
        self.local = local
        self.number = number
    }
}
