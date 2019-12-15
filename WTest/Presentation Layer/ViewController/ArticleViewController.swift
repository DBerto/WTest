//
//  ArticlesViewController.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation
import UIKit

final class ArticleViewController: GenericTableViewController<Item,ArticleTableViewCell>{
    
    // MARK: UIProperties
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var articleItensList: [Item] = []
    var currentPage: Int = 0
    let pageLimit: String = "10"
    
    // MARK: Services
    var articleService: IArticleService!
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table View
        //How to remove extra empty cells in TableViewController, iOS - Swift
        self.articleTableView.backgroundColor = UIColor.clear
        self.articleTableView.isScrollEnabled = true
        self.articleTableView.separatorStyle = .none
        
        articleService = AppDelegate.container.resolve(IArticleService.self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadIndicator.stopAnimating()
        #if VERSION2
        loadItems()
        #else
        loadArticle()
        #endif
        
        self.configureTable()
    }
 
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let isReachingEnd = scrollView.contentOffset.y >= 0
           && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
         
         if(isReachingEnd){
             #if VERSION2
             loadItems()
             #else
             loadArticle()
             #endif
        }
     }
    
    // MARK: Functions
    #if VERSION2
    func loadItems(){
        guard !loadIndicator.isAnimating else {
            return
        }
        
        loadIndicator.startAnimating()
        self.currentPage += 1

        self.articleService.getItemList(page: currentPage.toString(), limit: pageLimit, completion: ({
            (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let resultValue):
                    self.articleItensList.append(contentsOf: resultValue ?? [])
                    self.configureTable()
                    self.loadIndicator.stopAnimating()
                    self.articleTableView.reloadData()
                case .failure(let error):
                    self.loadIndicator.stopAnimating()
                    self.showAlertBar(title: "Error", message: error.customDescription)
                }
            }
        }))
    }
    #else
    func loadArticle(){
        guard !loadIndicator.isAnimating else {
            return
        }
        loadIndicator.startAnimating()
        
        self.articleService.getArticleList(page: currentPage.toString(), limit: pageLimit, completion: ({
            (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let resultValue):
                    self.articleItensList.append(contentsOf: resultValue?.items ?? [])
                    self.configureTable()
                    self.loadIndicator.stopAnimating()
                    self.articleTableView.reloadData()
                case .failure(let error):
                    self.showAlertBar(title: "Error", message: error.customDescription)
                }
            }
        }))
    }
    #endif
    private func configureTable() {
        configureTableCell(items: articleItensList, configure: { (cell: ArticleTableViewCell, item) in
            cell.articleItemView!.title?.text = item.title
            cell.articleItemView!.author?.text = item.author
            cell.articleItemView!.desc?.text = item.summary
        })
    }
    private func calculateIndexPathsToReload(from newItems: [Item]) -> [IndexPath] {
        let startIndex = articleItensList.count - newItems.count
        let endIndex = startIndex + newItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
