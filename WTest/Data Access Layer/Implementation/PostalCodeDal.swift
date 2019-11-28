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
    func getAllThatContains(text: String) -> [PostalCode] {
        let splitedText = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).split(separator: " ")
        
        var subPredicates: [NSPredicate] = []
        if splitedText.count <= 1{
            subPredicates.append(NSPredicate(format: "uuid CONTAINS[cd] %@", splitedText.joined()))
        }else{
            for text in splitedText {
                subPredicates.append(NSPredicate(format: "uuid CONTAINS[cd] %@", text.description))
            }
        }
        
        return respository.getAll(where: NSCompoundPredicate(type: .and, subpredicates: subPredicates))
    }
}

