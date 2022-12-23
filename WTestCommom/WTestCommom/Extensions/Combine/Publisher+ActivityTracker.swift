//
//  ActivityTracker.swift
//  allora
//
//  Created by Mouta, Manuel Matos on 04/03/2021.
//  Copyright © 2021 Zurich. All rights reserved.
//

import Combine
import UIKit

public typealias ActivityTracker = CurrentValueSubject<Bool, Never>
public typealias FieldActivityTracker = CurrentValueSubject<(String, Bool), Never>

public extension Publisher {
    func trackActivity(_ activityTracker: ActivityTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            activityTracker.send(true)
        }, receiveCompletion: { _ in
            activityTracker.send(false)
        }, receiveCancel: {
            activityTracker.send(false)
        })
        .eraseToAnyPublisher()
    }
    
    func trackFieldActivity(_ activityTracker: FieldActivityTracker, key: String) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            activityTracker.send((key, true))
        }, receiveCompletion: { _ in
            activityTracker.send((key, false))
        }, receiveCancel: {
            activityTracker.send((key, false))
        })
        .eraseToAnyPublisher()
    }
}
