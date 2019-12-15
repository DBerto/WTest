//
//  ArticleDal.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

class ArticleDal: GenericAPIClient, IArticleDal{
    
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    #if VERSION2
    /// Fetch Item
    func fetchItem(page: String, limit: String, completion: @escaping (Result<[Item]?, APIError>) -> ()) {
        
        let parameter = ArticleParameter(page: page, limit: limit)
        guard let request = ArticleFeed(articleParameter: parameter).getRequest(headers: []) else { return }
        
        fetch(with: request , decode: { json -> [Item]? in
            guard let results = json as? [Item] else { return  nil }
            return results
        }, completion: completion)
    }
    func fetchItem(completion: @escaping (Result<[Item]?, APIError>) -> ()) {
        guard let request = ArticleFeed(articleParameter: nil).getRequest(headers: []) else { return }
        
        fetch(with: request , decode: { json -> [Item]? in
            guard let results = json as? [Item] else { return  nil }
            return results
        }, completion: completion)
    }
    #else
    /// Fetch Article
    func fetchArticle(page: String, limit: String, completion: @escaping (Result<Article?, APIError>) -> ()) {
        
        let parameter = ArticleParameter(page: page, limit: limit)
        guard let request = ArticleFeed(articleParameter: parameter).getRequest(headers: []) else { return }
        
        fetch(with: request , decode: { json -> Article? in
            guard let results = json as? Article else { return  nil }
            return results
        }, completion: completion)
    }
    func fetchArticle(page: String, limit: String, completion: @escaping (Result<Article?, APIError>) -> ()) {
        
        guard let request = ArticleFeed(articleParameter: nil).getRequest(headers: []) else { return }
        
        fetch(with: request , decode: { json -> Article? in
            guard let results = json as? Article else { return  nil }
            return results
        }, completion: completion)
    }
    #endif
    
    
    
    
}
