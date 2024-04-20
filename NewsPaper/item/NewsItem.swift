//
//  NewsItem.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

struct NewsItem: Codable {
    var title: String
    var author: String
    var description: String
    var publishedAt: String
    var url: String
    var urlToImage: String
}
