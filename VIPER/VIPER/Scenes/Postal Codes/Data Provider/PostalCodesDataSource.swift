//
//  PostalCodesDataSource.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

class PostalCodesDataSource: TableDataSource {
    
    override internal func dequeueCell(in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        guard let field = viewModel?.item(for: indexPath) as? PostalCodeViewModel else {
            assertionFailure("Field is nill")
            return UITableViewCell()
        }
        
        guard let cell = dequeueCell(in: tableView, for: field, atIndexPath: indexPath) as? PostalCodeCell else {
            assertionFailure("Unknown cell type")
            return UITableViewCell()
        }
        cell.item = field
        return cell
    }
    
    private func dequeueCell(in tableView: UITableView, for field: Field, atIndexPath indexPath: IndexPath) -> UITableViewCell? {
        let identifier: String = PostalCodeCell.className
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
}
