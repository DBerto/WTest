//
//  Endpoint.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents(string: path)
        if(!queryItems.isEmpty){
            components?.queryItems = queryItems
        }
        return components?.url
    }
    
    var request: URLRequest? {
        guard let url = url else { return nil }
        let request = URLRequest(url: url)
        return request
    }
    
    func postRequest<T: Encodable>(parameters: T, headers: [HTTPHeader]) -> URLRequest? {
        
        guard var request = self.request else { return nil }
        request.httpMethod = HTTPMethods.post.rawValue
        do {
            request.httpBody = try JSONEncoder().encode(parameters)
        } catch let error {
            print(APIError.postParametersEncodingFalure(description: "\(error)").customDescription)
            return nil
        }
        headers.forEach { request.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        return request
    }
    
    func getRequest(headers: [HTTPHeader]) -> URLRequest? {
        
        guard var request = self.request else { return nil }
        request.httpMethod = HTTPMethods.get.rawValue
        
        headers.forEach { request.addValue($0.header.value, forHTTPHeaderField: $0.header.field) }
        return request
    }
}
