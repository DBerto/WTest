//
//  View.swift
//  MVVM
//
//  Created by David Manuel da Costa Berto on 23/12/2020.
//

import Foundation

protocol View {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
}
