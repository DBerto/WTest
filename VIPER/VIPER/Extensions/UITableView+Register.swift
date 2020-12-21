//
//  UITableView+Register.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 21/12/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: T.className)
    }
}
