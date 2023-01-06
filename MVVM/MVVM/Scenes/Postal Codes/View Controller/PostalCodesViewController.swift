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

protocol PostalCodesViewControllerProtocol: TableViewController { }

class PostalCodesViewController: TableViewController,
                                 PostalCodesViewControllerProtocol {
    
    // MARK: - Properties
    
    var viewModel: PostalCodesViewModel!
    var dataProvider: PostalCodesDataProvider!
    private(set) var input: ViewInputObservable<PostalCodesViewModel.ViewData> = .init()
    private var oldTextSearch: String?
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        bindViewModel()
        viewModel.performAction(.viewDidLoad)
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
        viewModel.viewState
            .asDriver()
            .sink { [weak self] viewDate in
                switch viewDate {
                case .isLoading(let value):
                    if value {
                        self?.refreshControl?.isHidden = false
                        self?.refreshControl?.beginRefreshing()
                    } else {
                        self?.refreshControl?.isHidden = true
                        self?.refreshControl?.endRefreshing()
                    }
                case .load(let model):
                    switch model {
                    case .dataSourceModel(let postalCodes):
                        self?.dataProvider.viewModel = postalCodes
                    }
                }
            }
            .store(in: disposeBag)
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
            viewModel.performAction(.search(text ?? ""))
        }
        
        oldTextSearch = text
    }
}

