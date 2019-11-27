//
//  PostalCodeDal.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

class PostalCodeDal: IPostalCodeDal{
    // MARK: Properties
    let respository: Repository<PostalCode>!
    
    init() {
        respository = Repository<PostalCode>()
    }
    
    // MARK: Functions
    func insert(postalCode: PostalCode)-> Bool {
        do {
            try respository.insert(item: postalCode)
            return true
        } catch {
            return false
        }
    }
    func insertMany(postalCodeList: [PostalCode])-> Bool {
        do {
            try respository.insertMany(items: postalCodeList)
            return true
        } catch {
            return false
        }
    }
    func getAll() -> [PostalCode] {
        return respository.getAll(where: nil)
    }
}
