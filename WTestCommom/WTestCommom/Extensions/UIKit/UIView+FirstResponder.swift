//
//  UIView+FirstResponder.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

extension UIView {
    func currentFirstResponder() -> UIResponder? {
        if self.isFirstResponder && self is UITextField {
            return self
        }
        
        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        
        return nil
    }
}
