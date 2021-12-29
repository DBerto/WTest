//
//  PostalCodesViewController.swift
//  MVVM
//
//  Created by David Berto on 29/12/2021.
//

import Foundation
import UIKit
import WTestCommon
import Combine

protocol PostalCodesViewControllerType: TableViewController {
    var viewDidLoadTrigger: Trigger { get }
    var searchRequestTrigger: PassthroughSubject<String?, Never> { get }
}

class PostalCodesViewController: TableViewController, PostalCodesViewControllerType {
    
    // MARK: - Properties
    private(set) var viewDidLoadTrigger: Trigger = .init()
    private(set) var searchRequestTrigger: PassthroughSubject<String?, Never> = .init()
    
    private var oldTextSearch: String?
    
    var viewModel: PostalCodesViewModel!
    var dataProvider: PostalCodesDataProvider!
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        bindViewModel()
        viewDidLoadTrigger.send(())
    }
    
    // MARK: - Setup
    
    private func setupNavBar() {
        navigationItem.title = R.string.localizable.postalCodes()
    }
    
    override func configureDataProvider() {
        hasRefreshControl = true
        hasSearchBar = true
        dataProvider.tableView = tableView
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        let output = viewModel.transform(input: PostalCodesViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger.asDriver(),
                                                                           searchRequestTrigger: searchRequestTrigger.asDriver()),
                                         disposeBag: disposeBag)
        output.dataSourceModel
            .asDriver()
            .sink { [weak self] dataSourceModel in
                self?.dataProvider.viewModel = dataSourceModel
            }.store(in: disposeBag)
        
        output.isSearching
            .dropFirst()
            .asDriver()
            .sink { [weak self] value in
                if value {
                    self?.refreshControl?.isHidden = false
                    self?.refreshControl?.beginRefreshing()
                } else {
                    self?.refreshControl?.isHidden = true
                    self?.refreshControl?.endRefreshing()
                }
            }.store(in: disposeBag)
    }
    
    // MARK: - UISearchResultsUpdating
    
    @objc override func refresHandler(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if oldTextSearch?.isEmpty == true {
            oldTextSearch = nil
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        oldTextSearch = nil
    }
    
    // MARK: - UISearchResultsUpdating
    
    override func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        
        if oldTextSearch != nil {
            searchRequestTrigger.send(text)
        }
        
        oldTextSearch = text
    }
}

