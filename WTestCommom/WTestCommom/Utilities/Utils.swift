//
//  Utils.swift
//  WTestCommon
//
//  Created by David Berto on 21/09/2021.
//

import Foundation

// MARK: - Enum aux
func resultOf<T>(_ code: () -> T) -> T {
    return code()
}
