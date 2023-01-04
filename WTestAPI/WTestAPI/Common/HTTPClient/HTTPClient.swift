//
//  HTTPClient.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation

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
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body,
                                                           options: [])
        }
        
        do {
            let (data, response) = try await client.session.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw APIError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                let decodedResponse = try decode(data,
                                                 decoder: .init(),
                                                 responseModel: responseModel,
                                                 responseFormat: endpoint.responseFormat)
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
