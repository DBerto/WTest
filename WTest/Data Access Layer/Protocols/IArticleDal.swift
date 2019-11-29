//
//  IArticleDal.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

protocol IArticleDal{
    #if VERSION2
    /// Fetch Item
     func fetchItem(page: String, limit: String, completion: @escaping (Result<[Item]?, APIError>) -> ())
    #else
    /// Fetch Article
     func fetchArticle(page: String, limit: String, completion: @escaping (Result<Article?, APIError>) -> ())
    #endif
}
