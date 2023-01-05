//
//  Date+Validations.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 05/01/2023.
//

import Foundation

extension Date {
    public func isBefore(date: Date)-> Bool {
        return date.timeIntervalSince(self) > 0
    }
}
