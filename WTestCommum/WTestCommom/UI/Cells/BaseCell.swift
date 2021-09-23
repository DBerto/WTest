//
//  BaseCell.swift
//  WTestCommon
//
//  Created by David Berto on 20/09/2021.
//

import Foundation
import UIKit

public typealias BindableBaseCell = BaseCell & BindableCell

public class BaseCell: UITableViewCell { }

public protocol BindableCell {
    func bindViewModel<T: FieldViewModel>(_ viewModel: T)
}
