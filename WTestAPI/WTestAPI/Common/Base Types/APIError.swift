//
//  RequestError.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation

public enum APIError: Error {
    case decodeFail
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case noConnection
    
    public var customMessage: String {
        switch self {
        case .decodeFail:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .noConnection:
            return "No connection"
        default:
            return "Unknown error"
        }
    }
}
