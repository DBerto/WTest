//
//  Publisher+ActivityTracker.swift
//  WTestCommon
//
//  Created by David Berto on 29/12/2021.
//

import Foundation
import Combine
import UIKit

public typealias ActivityTracker = CurrentValueSubject<Bool, Never>

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
}
