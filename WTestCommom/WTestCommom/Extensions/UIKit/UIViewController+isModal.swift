//
//  UIViewController+isModal.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    /**
     returns true only if the viewcontroller is presented.
     https://stackoverflow.com/questions/23620276/how-to-check-if-a-view-controller-is-presented-modally-or-pushed-on-a-navigation
     */
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self),
           index > 0 {
            return false
        } else if presentingViewController != nil {
            if let parent = parent,
               !(parent is UINavigationController || parent is UITabBarController) {
                return false
            }
            return true
        } else if let navController = navigationController,
                  navController.presentingViewController?.presentedViewController == navController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}
