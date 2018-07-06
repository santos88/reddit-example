//
//  ArticlesController.swift
//  RedditClient
//
//  Created by Santos Ramon on 06-07-18.
//  Copyright © 2018 Santos Ramon. All rights reserved.
//

import Foundation

class ArticlesController {

    var cache = [ArticleModel]()

    func loadArticles(completion: @escaping ([ArticleModel]?, Error?) -> Void) {
        ArticlesAPI().loadArticles(page: 1) { [weak self] (articles, error) in
            if let records = articles {
                self?.cache = records
            }
            completion(self?.cache, error)
        }
    }
    
    func articleWasReadAtIndex(row:Int) {
        cache[row].wasRead = true;
    }
    
    func remove(article:ArticleModel) {
        cache = cache.filter { $0 != article }
    }
    
    func removeAllArticles() {
        cache.removeAll()
    }
}
