//
//  ViewModelProtocol.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 23/12/2020.
//

import Foundation
import WTestCommon

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output
}
