//
//  ViewModelType.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 23/12/2020.
//

import Foundation
import WTestCommon

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output
}
