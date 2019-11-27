//
//  Utils.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

struct Config {
    
    static let postalCodeUrl = "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv"
    
    static private func getKey(key: String) -> String {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            return (dict[key]?.description)!
        }
        return ""
    }
}
