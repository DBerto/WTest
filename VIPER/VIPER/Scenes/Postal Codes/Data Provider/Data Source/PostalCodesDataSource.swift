//
//  PostalCodesDataSource.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit
import WTestCommon

class PostalCodesDataSource: TableDataSource {
    override func dequeueCell(in tableView: UITableView,
                              for fieldViewModel: FieldViewModel,
                              atIndexPath indexPath: IndexPath) -> BaseCell<FieldViewModel>? {
        let identifier: String = PostalCodeCell.className
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BaseCell<FieldViewModel>
    }
}
