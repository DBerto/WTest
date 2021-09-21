//
//  PassthroughSubject+Trigger.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Combine

public typealias Trigger = PassthroughSubject<Void, Never>

extension PassthroughSubject where Output == Void, Failure: Error {
    func trigger() {
        self.send(())
    }
}

