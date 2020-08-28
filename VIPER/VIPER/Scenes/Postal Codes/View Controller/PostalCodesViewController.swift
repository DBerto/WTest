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
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupDataProvider()
        eventHandler.viewIsLoaded()
    }
    
    // MARK: - Setup
    
    private func setupNavBar() {
        navigationItem.title = R.string.localizable.postalCodes()
    }
    
    private func setupDataProvider() {
        dataProvider = PostalCodesDataProvider(dataSource: dataSource)
        dataProvider.tableView = tableView
    }
    
    // MARK: - PostalCodesViewInterface
    
    func updateView(with viewModel: PostalCodesViewModel) {
        dataProvider.viewModel = viewModel
        reloadData()
    }
    
}
