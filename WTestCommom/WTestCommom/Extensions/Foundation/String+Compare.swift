//
//  String+Compare.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

extension String {
  func equalsIgnoreCase(_ string: String?) -> Bool {
      guard let string = string else {
          return false
      }

      return self.caseInsensitiveCompare(string) == .orderedSame
  }
}

extension Optional where Wrapped == String {
    func equalsIgnoreCase(_ string: String?) -> Bool {
        switch self {
        case .some(let value):
            return value.equalsIgnoreCase(string)
        case .none:
            return self == string
        }
    }
}
