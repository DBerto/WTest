//
//  PostalCodesRemoteRepository.swift
//  WTestAPI
//
//  Created by David Berto on 21/09/2021.
//

import Foundation
import WTestCommon
import Combine

public protocol PostalCodesRemoteRepositoryProtocol: HTTPClientProtocol {
    func getPostalCodes() async throws -> [PostalCodeResponse]
}

public final class PostalCodesRemoteRepository: PostalCodesRemoteRepositoryProtocol {
    public let client: NetworkAgent
    
    public init(client: NetworkAgent = .init()) {
        self.client = client
    }
    
    public func getPostalCodes() async throws -> [PostalCodeResponse] {
        try await sendRequest(endpoint: PostalCodeEndpoint.listOfPostalCodes,
                              responseModel: [PostalCodeResponse].self)
    }
}
