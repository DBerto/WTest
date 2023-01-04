//
//  PostalCodeEndpoint.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation

enum PostalCodeEndpoint {
    case listOfPostalCodes
    case exampleWithAuth
}

extension PostalCodeEndpoint: EndpointProtocol {
    var host: String {
        return "raw.githubusercontent.com"
    }
    
    var path: String {
        switch self {
        case .listOfPostalCodes:
            return "/centraldedados/codigos_postais/master/data/codigos_postais.csv"
        case .exampleWithAuth:
            return ""
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .listOfPostalCodes,
                .exampleWithAuth:
            return .get
        }
    }
    
    var header: [String: String]? {
        let accessToken = "insert your access token here"
        
        switch self {
        case .listOfPostalCodes:
            return nil
        case .exampleWithAuth:
            return [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .listOfPostalCodes,
                .exampleWithAuth:
            return nil
        }
    }
    
    var responseFormat: ResponseFormat {
        switch self {
        case .listOfPostalCodes:
            return .csv
        case .exampleWithAuth:
            return .json
        }
    }
}
