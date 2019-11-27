//
//  BaseViewController.swift
//  WTest
//
//  Created by David Berto on 27/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController{
    func showAlertBar(title: String, message: String){
        let alertController = UIAlertController(title: title, message:
               message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
           self.present(alertController, animated: true, completion: nil)
    }
}
