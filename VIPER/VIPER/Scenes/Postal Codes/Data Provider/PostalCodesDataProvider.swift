//
//  PostalCodesDataProvider.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit
import WTestCommon

class PostalCodesDataProvider: TableDataProvider {
    override func registerCells() {
        tableView?.register(PostalCodeCell.self)
    }
}

// MARK: - UITableViewDelegate

extension PostalCodesDataProvider {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
