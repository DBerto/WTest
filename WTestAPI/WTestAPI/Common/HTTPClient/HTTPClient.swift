//
//  HTTPClient.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation

public protocol HTTPClientProtocol {
    var client: NetworkAgent { get }
    func sendRequest<T: Decodable>(endpoint: EndpointProtocol,
                                   responseModel: T.Type) async -> Result<T, APIError>
}

extension HTTPClientProtocol {
    public func sendRequest<T: Decodable>(endpoint: EndpointProtocol,
                                   responseModel: T.Type) async -> Result<T, APIError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
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
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? decode(data,
                                                        decoder: .init(),
                                                        responseModel: responseModel,
                                                        responseFormat: endpoint.responseFormat) else {
                    return .failure(.decodeFail)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
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
