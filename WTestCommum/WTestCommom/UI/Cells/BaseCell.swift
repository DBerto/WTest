//
//  BaseCell.swift
//  WTestCommon
//
//  Created by David Berto on 20/09/2021.
//

import Foundation
import UIKit

public class BaseCell<T: FieldViewModel>: UITableViewCell {
    public var viewModel: T? {
        didSet {
            if let viewModel = viewModel {
                bindViewModel(viewModel)
            }
        }
    }
    
    func bindViewModel(_ viewModel: T) {
        assertionFailure("Override in subclass")
    }
}
