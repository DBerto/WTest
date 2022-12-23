//
//  Thread+XCTest.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

extension Thread {
    var isRunningXCTest: Bool {
        for key in self.threadDictionary.allKeys {
            guard let keyAsString = key as? String else {
                continue
            }
            
            if keyAsString.split(separator: ".").contains("xctest") {
                return true
            }
        }
        return false
    }
}
