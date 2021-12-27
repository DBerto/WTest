//
//  AnyCancellable+CancellableBag.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Combine

open class CancellableBag {
    var subscriptions = Set<AnyCancellable>()
    
    public init() { }
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    public func store(in bag: CancellableBag) {
        bag.subscriptions.insert(self)
    }
}
