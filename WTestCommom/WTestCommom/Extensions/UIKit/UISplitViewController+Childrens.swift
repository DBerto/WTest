//
//  UISplitViewController+Childrens.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

extension UISplitViewController {
    var primaryViewController: UIViewController? {
        return self.viewControllers.first
    }

    var secondaryViewController: UIViewController? {
        return self.viewControllers.count > 1 ? self.viewControllers[1] : nil
    }
}
