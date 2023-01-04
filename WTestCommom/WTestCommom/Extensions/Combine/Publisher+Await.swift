//
//  Publisher+await.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation
import Combine

// https://peterfriese.dev/posts/combine-vs-async/

extension Publisher {
    /// Executes an asyncronous call and returns its result to the downstream subscriber.
    ///
    /// - Parameter transform: A closure that takes an element as a parameter and returns a publisher that produces elements of that type.
    /// - Returns: A publisher that transforms elements from an upstream  publisher into a publisher of that element's type.
    public func `await`<T>(_ transform: @escaping (Output) async -> T) -> AnyPublisher<T, Failure> {
        flatMap { value -> Future<T, Failure> in
            Future { promise in
                Task {
                    let result = await transform(value)
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func `await`<T>(_ transform: @escaping () async -> T) -> AnyPublisher<T, Failure> {
        flatMap { _ -> Future<T, Failure> in
            Future { promise in
                Task {
                    let result = await transform()
                    promise(.success(result))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension Future where Failure == Error {
    public convenience init(asyncFunc: @escaping () async -> Result<Output, Failure>) {
        self.init { promise in
            Task {
                let result = await asyncFunc()
                switch result {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    public convenience init(asyncFunc: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                let result = try await asyncFunc()
                promise(.success(result))
            }
        }
    }
}
