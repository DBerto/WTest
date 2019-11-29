//
//  Endpoint.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

/// Protocol for easy construction of URls, ideally an enum will be the one conforming to this protocol.
protocol Endpoint {
    var path: String { get }
}

extension Endpoint {
    var request: URLRequest? {
        
        guard let url = URL(string: "\(self.path)") else { return nil }
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
    
    func getRequest<T: Encodable>(parameters: T, headers: [HTTPHeader]) -> URLRequest? {
           
           guard var request = self.request else { return nil }
           request.httpMethod = HTTPMethods.get.rawValue
           return request
       }
}
