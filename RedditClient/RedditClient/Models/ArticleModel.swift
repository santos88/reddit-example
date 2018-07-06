//
//  ArticleModel.swift
//  RedditClient
//
//  Created by Santos Ramon on 06-07-18.
//  Copyright © 2018 Santos Ramon. All rights reserved.
//

import Foundation

struct ArticleModel:Codable {
    var title:String
    var author:String
    var created:Date
    var thumbnail:String
    var num_comments:Int
    var wasRead:Bool?
}

struct ArticlesServerResponse:Codable {
    struct ArticlesData:Codable {
        struct Children:Codable {
            var kind:String
            var data:ArticleModel
        }
        var children : [Children]
    }
    var data:ArticlesData
    var kind:String
    
    func articlesArray() -> [ArticleModel] {
        return data.children.map{ $0.data }
    }
    
}
