//
//  PostalCodesDataProvider.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

class PostalCodesDataProvider: NSObject {
    
    // MARK: - Properties
    
    let dataSource: PostalCodesDataSource
    var tableView: UITableView? {
        didSet {
            registerCells()
            tableView?.dataSource = dataSource
            tableView?.delegate = self
        }
    }
    var viewModel: PostalCodesViewModel? {
        didSet {
            dataSource.viewModel = viewModel
        }
    }
    
    required init(dataSource: PostalCodesDataSource) {
        self.dataSource = dataSource
    }
    
    func registerCells() {
        tableView?.register(PostalCodeCell.self, forCellReuseIdentifier: PostalCodeCell.className)
    }
    
}

// MARK: - UITableViewDelegate

extension PostalCodesDataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
