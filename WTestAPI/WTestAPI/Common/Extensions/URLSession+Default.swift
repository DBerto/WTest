//
//  URLSession+Default.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation
import Network

public extension URLSession {
    static var defaultSession: URLSession {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForResource = 300
        return URLSession(configuration: config)
    }
}
