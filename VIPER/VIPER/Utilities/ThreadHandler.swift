//
//  ThreadHandler.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 21/12/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

typealias MethodHandler = () -> Void

func executeInMainThread(_ execution : @escaping MethodHandler, after: Double = 0.0) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        execution()
    }
}

func executeInBackgroundThread(_ execution : @escaping MethodHandler, after: Double = 0.0) {
    DispatchQueue.global().asyncAfter(deadline: .now() + after) {
        execution()
    }
}
