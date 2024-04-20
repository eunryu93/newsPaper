//
//  NewsItem.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import RealmSwift

struct NewsItem: Codable {
    var title: String
    var author: String?
    var description: String?
    var publishedAt: String?
    var url: String?
    var urlToImage: String?
}

class LocalNewsItem: Object {
    @Persisted var title: String
    @Persisted var author: String?
    @Persisted var desc: String?
    @Persisted var publishedAt: String?
    @Persisted var url: String?
    @Persisted var urlToImage: String?
    
    convenience init(data: NewsItem) {
        self.init()
        self.title = data.title
        self.author = data.author
        self.desc = data.description
        self.publishedAt = data.publishedAt
        self.url = data.url
        self.urlToImage = data.urlToImage
    }
}
