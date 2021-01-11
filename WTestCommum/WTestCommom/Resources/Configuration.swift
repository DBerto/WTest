//
//  Environment.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 26/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

public enum InfoPlistKeys: String {
    case postalCodeURL = "POSTAL_CODE_URL"
    case articleV1URL = "ARTICLE_V1_URL"
    case articleV2URL = "ARTICLE_V2_URL"
    case configuration = "Config"
}

public struct Configuration {
    
    public static let postalCodeURL: String = {
        return fetchKeyValue(infoPlistKey: InfoPlistKeys.postalCodeURL)
    }()
    
    public static let articlesApiUrl: String = {
        #if VERSION2
        return fetchKeyValue(infoPlistKey: InfoPlistKeys.articleV2URL)
        #else
        return fetchKeyValue(infoPlistKey: InfoPlistKeys.articleV1URL)
        #endif
    }()
    
    static private func fetchKeyValue(infoPlistKey: InfoPlistKeys) -> String {
        if let path = Bundle.main.path(forResource: InfoPlistKeys.configuration.rawValue, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            return (dict[infoPlistKey.rawValue]?.description)!
        }
        return ""
    }
}
