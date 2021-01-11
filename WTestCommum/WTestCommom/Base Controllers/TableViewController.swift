//
//  TableViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

open class TableViewController: BaseViewController {
    
    // MARK: - Properties
    
    public var tableView: UITableView!
    public var searchController: UISearchController?
    public var tableViewStyle: UITableView.Style! = .grouped {
        didSet {
            setupTableView()
        }
    }
    public var hasRefreshControl: Bool = false {
        didSet {
            configureRefreshControl(value: hasRefreshControl)
        }
    }
    public var hasSearchBar: Bool = false {
        didSet {
            setupSearchController(hasSearchBar: hasSearchBar)
        }
    }
    // MARK: - Override
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
    }
    
    // MARK: - Setup
    
    open func setupTableView() {
        if tableView != nil {
            tableView.removeFromSuperview()
        }
        
        tableView = UITableView(frame: .zero, style: tableViewStyle)
        view.addSubview(tableView)
        addTableViewConstraints()
        configureDataProvider()
    }
    
    open func addTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    open func configureDataProvider() {
        assertionFailure("Should be implemented by is subclasses")
    }
    
    private func setupView() {
        view.backgroundColor = tableView.backgroundColor
    }
}

// MARK: - UIRefreshControl

extension TableViewController {
    private func configureRefreshControl(value: Bool) {
        if value && tableView.refreshControl == nil {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refresHandler(_:)), for: .valueChanged)
            tableView.refreshControl = refreshControl
        } else if !value && tableView.refreshControl != nil {
            tableView.refreshControl = nil
        }
    }
    
    @objc open func refresHandler(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
        assertionFailure("Should be implemented by is subclasses")
    }
}

// MARK: - UISearchBarDelegate

extension TableViewController: UISearchBarDelegate {
    open func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchResultsUpdating

extension TableViewController: UISearchResultsUpdating {
    open func setupSearchController(hasSearchBar: Bool) {
        if !hasSearchBar {
            navigationItem.searchController = nil
        } else if searchController?.searchBar.superview == nil {
            searchController = UISearchController(searchResultsController: nil)
            searchController!.searchResultsUpdater = self
            searchController!.obscuresBackgroundDuringPresentation = false
            searchController!.searchBar.placeholder = " Search Here"
            searchController!.searchBar.delegate = self
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            definesPresentationContext = true
        }
    }
    
    open func updateSearchResults(for searchController: UISearchController) {
        assertionFailure("Should be implemented by is subclasses")
    }
}

