//
//  UIView+RoundedCorners.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

extension UIView {
    func setRoundedCorners(radius: CGFloat? = nil,
                           maskedCorners: CACornerMask = [CACornerMask.layerMaxXMaxYCorner,
                                                          CACornerMask.layerMaxXMinYCorner,
                                                          CACornerMask.layerMinXMaxYCorner,
                                                          CACornerMask.layerMinXMinYCorner]) {
        if let radius = radius {
            layer.cornerRadius = radius
        } else {
            layer.cornerRadius = (min(bounds.width, bounds.height))/2
        }
        
        layer.maskedCorners = maskedCorners
        clipsToBounds = true
    }
}
