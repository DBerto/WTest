//
//  Publisher+Background.swift
//  WTestCommon
//
//  Created by David Berto on 01/03/2022.
//

import Combine
import Foundation

public typealias BackgroundActivity<T> = ObservableType<T>

extension Publisher {
    public func asBackgroundActivity() -> BackgroundActivity<Output> {
        return self
            .subscribe(on: DispatchQueue.global(qos: .background))
            .asObservable()
    }
}
