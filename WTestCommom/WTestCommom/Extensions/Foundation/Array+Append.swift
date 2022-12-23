//
//  Array+Append.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

extension Array {
    func unique<T: Hashable>(map: ((Element) -> (T))) -> [Element] {
        var set = Set<T>() // the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() // keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
    
    mutating func append(_ newElement: Element, condition: Bool) {
        if condition {
            self.append(newElement)
        }
    }
    
    mutating func append(contentsOf elements: [Element], condition: Bool) {
        if condition {
            self.append(contentsOf: elements)
        }
    }
    
    mutating func removeLast(condition: Bool) {
        if condition {
            self.removeLast()
        }
    }
    
    mutating func insert(_ newElement: Element, at index: Int, condition: Bool) {
        if condition {
            self.insert(newElement, at: index)
        }
    }
}
