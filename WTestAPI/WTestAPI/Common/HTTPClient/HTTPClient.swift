//
//  HTTPClient.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation
import WTestCommon

// https://betterprogramming.pub/async-await-generic-network-layer-with-swift-5-5-2bdd51224ea9

public protocol HTTPClientProtocol {
    var client: NetworkAgent { get }
    func sendRequest<T: Decodable>(endpoint: EndpointProtocol,
                                   responseModel: T.Type) async throws -> T
}

extension HTTPClientProtocol {
    public func sendRequest<T: Decodable>(endpoint: EndpointProtocol,
                                          responseModel: T.Type) async throws -> T {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        request.cachePolicy = endpoint.cachePolicy
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body,
                                                           options: [])
        }
        
        do {
            var data: Data!
            var response: URLResponse!
            
            if client.monitor.status == .disconnected {
                guard let cachedResponse = client.cache.cachedResponse(for: request) else {
                    throw APIError.noConnection
                }
                
                data = cachedResponse.data
                response = cachedResponse.response
            } else {
                let result = try await client.session.data(for: request)
                data = result.0
                response = result.1
            }
            
            guard let response = response as? HTTPURLResponse else {
                throw APIError.noResponse
            }
            
            switch response.statusCode {
            case 200...299:
                let decodedResponse = try decode(data,
                                                 decoder: .init(),
                                                 responseModel: responseModel,
                                                 responseFormat: endpoint.responseFormat)
                
                client.cache.storeCachedResponse(.init(response: response,
                                                       data: data),
                                                 for: request)
                
                return decodedResponse
            case 401:
                throw APIError.unauthorized
            default:
                throw APIError.unexpectedStatusCode
            }
        } catch {
            throw APIError.unknown
        }
    }
    
    private func decode<T: Decodable>(_ data: Data,
                                      decoder: JSONDecoder,
                                      responseModel: T.Type,
                                      responseFormat: ResponseFormat) throws -> T {
        switch responseFormat {
        case .json:
            return try decoder.decode(T.self, from: data)
        case .csv:
            let data = try NetworkUtils.shared.parseCSV(data: data)
            return try decoder.decode(T.self, from: data)
        }
    }
}
