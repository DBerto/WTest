//
//  IPostalCodeDal.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

protocol IPostalCodeDal {
    func insert(postalCode: PostalCode)-> Bool
    func insertMany(postalCodeList: [PostalCode])-> Bool
    func getAll()-> [PostalCode]
    func getAllThatContains(text: String)-> [PostalCode]
}
