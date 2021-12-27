//
//  Publisher+ErrorTracker.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Combine

public typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher {
    public func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}

