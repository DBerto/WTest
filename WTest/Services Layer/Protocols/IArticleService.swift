//
//  IArticleService.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

protocol IArticleService{
    #if VERSION2
    func getItemList(page: String, limit: String, completion: @escaping (Result<[Item]?, APIError>) -> ())
    #else
    func getArticleList(page: String, limit: String, completion: @escaping (Result<Article?, APIError>) -> ())
    #endif
}
