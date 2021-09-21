//
//  ThreadSafe.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Foundation

@propertyWrapper
final class ThreadSafe<T> {
    
    private let synchronizedQueue = DispatchQueue(label: "threadSafe.\(T.self).\(UUID().uuidString)",
                                                  attributes: .concurrent)
    private var objectValue: T!
    
    init(wrappedValue value: T) {
        self.objectValue = value
    }
    
    var wrappedValue: T {
        get { synchronizedQueue.sync { objectValue } }
        set { synchronizedQueue.sync(flags: .barrier) { self.objectValue = newValue } }
    }
}
