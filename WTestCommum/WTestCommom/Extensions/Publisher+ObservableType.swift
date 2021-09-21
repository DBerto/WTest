//
//  Publisher+ObservableType.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Combine

public typealias ObservableType<T> = AnyPublisher<T, Error>

extension Publisher {
    public func asObservable() -> ObservableType<Output> {
        self.mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    public static func just(_ output: Output) -> ObservableType<Output> {
        Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    public static func empty() -> ObservableType<Output> {
        return Empty().eraseToAnyPublisher()
    }
}
