//
//  GenericTableViewController.swift
//  WTest
//
//  Created by David Berto on 28/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

class GenericTableViewController<T, Cell: UITableViewCell>: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var items: [T] = []
    var configure: ((Cell, T) -> Void)?
    
    // MARK: Functions
    func configureTableCell(items: [T], configure: ((Cell, T) -> Void)?) {
        self.items = items
        self.configure = configure
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // O Identifier da Cell tem de ter o mesmo nome que a class
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "\(Cell.self)", for: indexPath) as? Cell)!
        let item = items[indexPath.row]
        configure!(cell, item)
        
        cell.selectionStyle = .default
        let viewSelection = UIView()
        viewSelection.backgroundColor = .white
        cell.selectedBackgroundView = viewSelection
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
