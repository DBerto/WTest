//
//  UIView+Accessibility.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

extension UIView {
    func setupAccessibility(key: String) {
        isAccessibilityElement = true
        accessibilityIdentifier = key
        
        if let tableCell = self as? UITableViewCell,
           let accessibilityIdentifier = self.accessibilityIdentifier {
            tableCell.contentView.accessibilityIdentifier = accessibilityIdentifier + "-contentView"
        }
        
        if let collectionCell = self as? UICollectionViewCell,
           let accessibilityIdentifier = self.accessibilityIdentifier {
            collectionCell.contentView.accessibilityIdentifier = accessibilityIdentifier + "-contentView"
        }
    }
}
