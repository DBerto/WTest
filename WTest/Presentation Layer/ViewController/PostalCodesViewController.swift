//
//  ListaCodigosPostaisViewController.swift
//  WTest
//
//  Created by David Berto on 28/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

final class PostalCodesListViewController: GenericTableViewController<PostalCode,PostalCodeTableViewCell>{
    
    // MARK: UIProperties
    @IBOutlet weak var postalCodesTableCell: UITableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    lazy var searchController: UISearchController = {
        let src = UISearchController(searchResultsController: nil)
        src.searchResultsUpdater = self
        src.obscuresBackgroundDuringPresentation = false
        src.hidesNavigationBarDuringPresentation = false
        src.definesPresentationContext = true
        src.searchBar.placeholder = "Search"
        return src
    }()
    
    //MARK: Properties
    private var postalCodesList: [PostalCode] = []
    private var filteredPostalCodes: [PostalCode] = []
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return !isSearchBarEmpty
    }
    
    // MARK: Constraints
    var bottomPostalCodesTableConstraint: NSLayoutConstraint?
    
    // MARK: Services
    private var postalCodeService: IPostalCodeService!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Table View
        //How to remove extra empty cells in TableViewController, iOS - Swift
        self.postalCodesTableCell.backgroundColor = UIColor.clear
        self.postalCodesTableCell.isScrollEnabled = true
        self.postalCodesTableCell.separatorStyle = .none
        
        // Setup Search Controller
        navigationItem.searchController = searchController
        
        // Add observer for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        self.loadIndicator.startAnimating()
        loadPostalCodesList()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPostalCodes.count
        }
        
        return postalCodesList.count
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostalCodeTableViewCell", for: indexPath) as! PostalCodeTableViewCell
        let postalCode: PostalCode
        if isFiltering {
            postalCode = filteredPostalCodes[indexPath.row]
        } else {
            postalCode = postalCodesList[indexPath.row]
        }
        cell.postalCodeView.postalCodeNum.text = postalCode.numCodPostal
        cell.postalCodeView.postalCodeExt.text = postalCode.extCodPostal
        cell.postalCodeView.postalCodeDesc.text = postalCode.desigPostal
        return cell
    }
    
    // MARK: Functions
    private func loadPostalCodesList(){
        DispatchQueue.global().async {
            // Realm needs to be initialize in the same thread that is used
            self.postalCodeService = AppDelegate.container.resolve(IPostalCodeService.self)
            self.postalCodeService.getAllPostalCodeList(completion: {
                (resultList) in
                self.postalCodesList.append(contentsOf: resultList)
                DispatchQueue.main.async {
                    self.configureTable()
                    self.loadIndicator.stopAnimating()
                    self.postalCodesTableCell.reloadData()
                }
            })
        }
    }
    private func configureTable() {
        configureTableCell(items: postalCodesList, configure: { (cell: PostalCodeTableViewCell, postalCode) in
            cell.postalCodeView!.postalCodeNum?.text = postalCode.numCodPostal
            cell.postalCodeView!.postalCodeExt?.text = postalCode.extCodPostal
            cell.postalCodeView!.postalCodeDesc?.text = postalCode.desigPostal
        })
    }
    private func filterContentForSearchText(_ searchText: String) {
        // Realm needs to be initialize in the same thread that is used
        self.postalCodeService = AppDelegate.container.resolve(IPostalCodeService.self)
        postalCodeService.getAllPostalCodeListWhere(text: searchText, completion: { (resultList) in self.filteredPostalCodes = resultList })
        postalCodesTableCell.reloadData()
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
        bottomPostalCodesTableConstraint = NSLayoutConstraint(item: self.view!, attribute: .bottom, relatedBy: .equal, toItem: postalCodesTableCell, attribute: .bottom, multiplier: 1.0, constant: keyboardSize!.height)
        NSLayoutConstraint.activate([bottomPostalCodesTableConstraint!])
    }
    @objc func keyboardWillHide() {
        NSLayoutConstraint.deactivate([bottomPostalCodesTableConstraint!])
    }
}

extension PostalCodesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}


