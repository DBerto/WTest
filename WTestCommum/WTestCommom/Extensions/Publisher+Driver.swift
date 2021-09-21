//
//  Publisher+Driver.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Combine
import Foundation

public typealias Driver<T> = AnyPublisher<T, Never>

extension Publisher {
    public func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    public static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }
    
    public static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }
}

