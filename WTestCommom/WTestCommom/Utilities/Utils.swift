//
//  Utils.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Foundation

public func resultOf<T>(_ code: () -> T) -> T {
    return code()
}

public func isNil<T>(_ obj: T?) -> Bool {
    return obj == nil
}
