//
//  ViewModelType.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 23/12/2020.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
