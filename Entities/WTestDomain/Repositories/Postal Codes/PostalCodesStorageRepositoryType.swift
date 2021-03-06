//
//  PostalCodesStorageRepositoryInterface.swift
//  WTestDomain
//
//  Created by David Manuel da Costa Berto on 27/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

public protocol PostalCodesStorageRepositoryType {
    func savePostalCode(_ postalCode: PostalCode, completion: @escaping (Result<Void, Error>) -> Void)
    func savePostalCodes(_ postalCode: [PostalCode], completion: @escaping (Result<Void, Error>) -> Void)
    func fetchPostalCodes(withPredicate predicate: NSPredicate?, completion: @escaping (Result<[PostalCode], Error>) -> Void)
}
