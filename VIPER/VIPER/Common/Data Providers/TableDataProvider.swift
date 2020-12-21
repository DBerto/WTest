//
//  TableDataProvider.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 21/12/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

class TableDataProvider: NSObject, UITableViewDelegate {
    let dataSource: TableDataSource
    var tableView: UITableView? {
        didSet {
            registerCells()
            tableView?.dataSource = dataSource
            tableView?.delegate = self
        }
    }
    var viewModel: TableViewModelBase? {
        didSet {
            dataSource.viewModel = viewModel
        }
    }
    
    required init(dataSource: TableDataSource) {
        self.dataSource = dataSource
    }
    
    func registerCells() {
        assertionFailure("Should be implemented by is subclasses")
    }
}
