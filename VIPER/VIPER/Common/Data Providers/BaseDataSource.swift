//
//  BaseDataSource.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import UIKit
import Foundation

class TableDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Properties
    
    var viewModel: TableViewModel?
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSections = viewModel?.numberOfSections() else {
            return 0
        }
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel, viewModel.numberOfSections() > 0 else {
            return 0
        }
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel, viewModel.numberOfSections() > section else {
            return nil
        }
        return viewModel.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let viewModel = viewModel, viewModel.numberOfSections() > section else {
            return nil
        }
        return viewModel.sections[section].footer
    }
    
    func dequeueCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        assertionFailure("must be implemented by its subclasses")
        return UITableViewCell()
    }
}
