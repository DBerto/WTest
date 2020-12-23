//
//  PostalCodesViewController.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation
import UIKit

class PostalCodesViewController: TableViewController, PostalCodesViewInterface {
    
    // MARK: - Properties
    
    var eventHandler: PostalCodesEventHandler!
    let dataSource = PostalCodesDataSource()
    var dataProvider: PostalCodesDataProvider!
    
    private var typingTimer: Timer?
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        eventHandler.viewIsLoaded()
    }
    
    // MARK: - Setup
    
    private func setupNavBar() {
        navigationItem.title = R.string.localizable.postalCodes()
    }
    
    override func configureDataProvider() {
        hasRefreshControl = true
        hasSearchBar = true
        dataProvider = PostalCodesDataProvider(dataSource: dataSource)
        dataProvider.tableView = tableView
        tableView.reloadData()
    }
    
    // MARK: - PostalCodesViewInterface
    
    func updateView(with viewModel: PostalCodesViewModel) {
        executeInMainThread { [weak self] in
            self?.dataProvider.viewModel = viewModel
            self?.tableView.reloadData()
        }
    }
    
    func updateLoadingIndicator(_ value: Bool) {
        if value {
            tableView.refreshControl?.isHidden = false
            tableView.refreshControl?.beginRefreshing()
        } else {
            executeInMainThread { [weak self] in
                self?.tableView.refreshControl?.isHidden = true
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc override func refresHandler(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    // MARK: - UISearchResultsUpdating
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { }
    
    // MARK: - UISearchResultsUpdating
    
    override func updateSearchResults(for searchController: UISearchController) {
        typingTimer?.invalidate()
        startTypingTimerFor(searchController)
    }
        
    private func startTypingTimerFor(_ searchController: UISearchController) {
        typingTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.typingTimer?.invalidate()
            self?.eventHandler.searchRequest(withText: searchController.searchBar.text ?? "")
        }
    }
}
