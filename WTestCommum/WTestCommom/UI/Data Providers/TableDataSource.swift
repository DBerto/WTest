//
//  BaseDataSource.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import UIKit
import Foundation

open class TableDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    open var viewModel: TableViewModelBase?
    
    // MARK: - UITableViewDataSource
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSections = viewModel?.numberOfSections() else {
            return 0
        }
        return numberOfSections
    }
    
    open func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel, viewModel.numberOfSections() > 0 else {
            return 0
        }
        return viewModel.numberOfRows(in: section)
    }
    
    open func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView, for: indexPath)
        return cell
    }
    
    open func tableView(_ tableView: UITableView,
                        titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel, viewModel.numberOfSections() > section else {
            return nil
        }
        return viewModel.sections[section].title
    }
    
    open func dequeueCell(in tableView: UITableView,
                          for indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel?.item(for: indexPath) else {
            assertionFailure("FieldViewModel is nill")
            return UITableViewCell()
        }
        
        guard let cell = dequeueCell(in: tableView,
                                     for: viewModel,
                                     atIndexPath: indexPath) as? BindableBaseCell else {
            assertionFailure("Unknown cell type")
            return UITableViewCell()
        }
        
        cell.bindViewModel(viewModel)
        return cell
    }
    
    open func dequeueCell(in tableView: UITableView,
                          for fieldViewModel: FieldViewModel,
                          atIndexPath indexPath: IndexPath) -> UITableViewCell? {
        assertionFailure("Override in subclass")
        return nil
    }
}
