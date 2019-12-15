//
//  ArticleService.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

final class ArticleService: IArticleService{
    private var articleDal: IArticleDal!
    
    init(articleDal: IArticleDal) {
        self.articleDal = articleDal
    }
    
    #if VERSION2
    func getItemList(page: String?, limit: String?, completion: @escaping (Result<[Item]?, APIError>) -> ()){
        if page != nil && limit != nil{
            articleDal.fetchItem(page: page!, limit: limit!, completion: ({
                (result) in
                completion(result)
            }))
        }
        else{
            articleDal.fetchItem(completion: ({
                (result) in
                completion(result)
            }))
        }
    }
    #else
    func getArticleList(page: String, limit: String, completion: @escaping (Result<Article?, APIError>) -> ()){
        
        if page != nil && limit != nil{
            articleDal.fetchArticle(page: page, limit: limit, completion: ({
                (result) in
                completion(result)
            }))
        }
        else{
            articleDal.fetchArticle(completion: ({
                (result) in
                completion(result)
            }))
        }
    }
    #endif
}
