//
//  Utils.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Foundation

func resultOf<T>(_ code: () -> T) -> T {
    return code()
}

func isNil<T>(_ obj: T?) -> Bool {
    return obj == nil
}
