//
//  EndpointProtocol.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation

public protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var responseFormat: ResponseFormat { get }
    var cachePolicy: URlCachePolicy { get }
}

extension EndpointProtocol {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }
    
    var cachePolicy: URlCachePolicy {
        return .reloadIgnoringLocalCacheData
    }
}
