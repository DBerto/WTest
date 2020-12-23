//
//  NSObject+ClassName.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

extension NSObject {
    public var className: String {
        return "\(type(of: self))"
    }
    
    public class var className: String {
        return "\(self)"
    }
}
