//
//  PostalCodesDataSource.swift
//  MVVM
//
//  Created by David Berto on 29/12/2021.
//

import Foundation
import UIKit
import WTestCommon

class PostalCodesDataSource: TableDataSource {
    override open func dequeueCell(in tableView: UITableView,
                                   for fieldViewModel: FieldViewModel,
                                   atIndexPath indexPath: IndexPath) -> UITableViewCell? {
        let identifier: String = PostalCodeCell.className
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}
