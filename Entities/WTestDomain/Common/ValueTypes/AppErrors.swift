//
//  AppErrors.swift
//  WTestDomain
//
//  Created by Berto, David Manuel  on 04/01/2023.
//  Copyright © 2023 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import WTestAPI

public enum AppErrors: Error,
                       Equatable,
                       Hashable {
    case ok // No error
    
    case recordNotFound
    case genericError(devMessage: String)
    case parsing(description: String)
    case network(description: String)
    case noInternetConnection
}

extension APIError {
    public func toAppError() -> AppErrors {
        switch self {
        case .decodeFail:
            return .parsing(description: customMessage)
        case .invalidURL,
                .noResponse,
                .unauthorized,
                .unexpectedStatusCode,
                .unknown:
            return .network(description: customMessage)
        case .noConnection:
            return .noInternetConnection
        }
    }
}
