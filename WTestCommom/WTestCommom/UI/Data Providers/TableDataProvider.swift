//
//  TableDataProvider.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 21/12/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

open class TableDataProvider: NSObject, UITableViewDelegate {
    public let dataSource: TableDataSource
    public var tableView: UITableView? {
        didSet {
            registerCells()
            tableView?.dataSource = dataSource
            tableView?.delegate = self
        }
    }
    public var viewModel: TableViewModelBase? {
        didSet {
            dataSource.viewModel = viewModel
            tableView?.reloadData()
        }
    }
    
    required public init(dataSource: TableDataSource) {
        self.dataSource = dataSource
    }
    
    open func registerCells() {
        assertionFailure("Should be implemented by is subclasses")
    }
}
