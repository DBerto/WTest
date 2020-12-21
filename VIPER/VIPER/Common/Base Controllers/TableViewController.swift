//
//  TableViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: BaseViewController {
    
    // MARK: - Properties
    
    var tableView: UITableView!
    var tableViewStyle: UITableView.Style! = .grouped {
        didSet {
            setupTableView()
        }
    }
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    // MARK: - Setup
    
    func setupTableView() {
        if tableView != nil {
            tableView.removeFromSuperview()
        }
        
        tableView = UITableView(frame: .zero, style: tableViewStyle)
        view.addSubview(tableView)
        addTableViewConstraints()
        configureDataProvider()
    }
    
    func addTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureDataProvider() {
        assertionFailure("Should be implemented by is subclasses")
    }
    
    private func setupView() {
        view.backgroundColor = tableView.backgroundColor
    }
}
