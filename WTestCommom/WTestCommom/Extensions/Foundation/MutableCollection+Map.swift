//
//  MutableCollection+Map.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

extension MutableCollection where Element == String? {
    func compactMapJoined(by separator: String) -> String? {
        let value = self.compactMap { $0 }
        return value.isEmpty ? nil : value.joined(separator: separator)
    }
}

extension MutableCollection where Element == NSMutableAttributedString? {
    func compactMapJoined(by separator: String) -> NSMutableAttributedString {
        let value = self.compactMap { $0 }.filter { !$0.string.isEmpty }
        let result = NSMutableAttributedString()
        
        value.enumerated().forEach { (index, elem) in
            result.append(elem)
            
            if index != value.count - 1 {
                result.append(.init(string: separator))
            }
        }
        
        return result
    }
}
