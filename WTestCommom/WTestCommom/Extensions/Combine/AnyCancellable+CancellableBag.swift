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
    
    public func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

open class DictCancellableBag {
    var subscriptions = [String: Set<AnyCancellable>]()
    
    func cancel(forID id: String) {
        subscriptions[id]?.forEach { $0.cancel() }
        subscriptions[id]?.removeAll()
    }
}

extension AnyCancellable {
    public func store(withID id: String,
                      in bag: DictCancellableBag) {
        var currentSet: Set<AnyCancellable> = bag.subscriptions[id] ?? .init()
        currentSet.insert(self)
        bag.subscriptions[id] = currentSet
    }
    
    public func store(in bag: CancellableBag) {
        bag.subscriptions.insert(self)
    }
}
