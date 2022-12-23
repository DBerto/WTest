//
//  RangeReplaceableCollection+Operations.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

extension RangeReplaceableCollection where Element: Equatable {
    /// Adds a new element to the collection if does not exists already
    /// - Parameters:
    ///   - element: The new element to be added
    ///   - predicate: The predicate to filter out the elements in the collection
    /// - Returns: true if the new element has been added, false otherwise
    
    @discardableResult
    mutating func append(_ element: Element, where predicate: (Self.Element) throws -> Bool) -> Bool {
        if (try? contains(where: predicate)) == false {
            append(element)
            return true
        }
        return false
    }
    
    @discardableResult
    mutating func appendIfNew(_ element: Element) -> Bool {
        if !contains(element) {
            append(element)
            return true
        }
        return false
    }
    
    mutating func appendIfNew(contentsOf elements: [Element]) {
        elements.forEach {
            appendIfNew($0)
        }
    }
    
    mutating func addOrUpdate(_ element: Element, where predicate: (Self.Element) -> Bool) {
        if let index = firstIndex(where: predicate) {
            remove(at: index)
            insert(element, at: index)
        } else {
            append(element)
        }
    }
    
    mutating func update(_ element: Element, where predicate: (Self.Element) -> Bool) {
        if let index = firstIndex(where: predicate) {
            remove(at: index)
            insert(element, at: index)
        }
    }
}
