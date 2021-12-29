//
//  PostalCodesDataProvider.swift
//  MVVM
//
//  Created by David Berto on 29/12/2021.
//

import Foundation
import UIKit
import WTestCommon

class PostalCodesDataProvider: TableDataProvider {
    override open func registerCells() {
        tableView?.register(PostalCodeCell.self)
    }
}

// MARK: - UITableViewDelegate

extension PostalCodesDataProvider {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
