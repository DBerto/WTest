//
//  ViewModelProtocol.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 23/12/2020.
//

import Foundation
import Combine
import WTestCommon

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input,
                   disposeBag: CancellableBag) -> Output
}

public class ViewInputObservable<T: Hashable>: ObservableObject {
    public init() { }
    public var value = PassthroughSubject<ViewInput<T>, Never>()
}

public enum ViewInput<T: Hashable> {
    case load(T)
    case isLoading(Bool)
}
