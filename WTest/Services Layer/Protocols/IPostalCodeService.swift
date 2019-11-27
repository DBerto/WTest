//
//  IPostalCodeService.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

protocol  IPostalCodeService {
    func downloadAndSavePostalCodes(from postalCodeUrl: URL, to destinationURL: URL, completion: @escaping (Bool) -> Void)
    func parseCSVToPostalCodeList(originPath: String, completion: @escaping ([PostalCode]) -> Void)
    func savePostalCodeListToRealm(postalCodeList: [PostalCode])-> Bool
}
