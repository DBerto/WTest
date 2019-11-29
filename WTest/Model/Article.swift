//
//  Article.swift
//  WTest
//
//  Created by David Berto on 29/11/2019.
//  Copyright © 2019 David Berto. All rights reserved.
//

import Foundation

// MODEL THAT WILL RETURN FROM REQUEST
struct Article: Decodable{
    let items: [Item]
}

struct Item: Decodable{
    let id: String
    let title: String
    let hero: String
    let author: String
    let summary: String
}

/// MODEL PARAMETER REQUESTED FOR THE API
struct ArticleParameter: Encodable{
    let page: String
    let limit: String
}

/// ENDPOINT CONFORMANCE
struct ArticleFeed: Endpoint {
    var path: String {
        return Config.articlesApiUrl
    }
}
