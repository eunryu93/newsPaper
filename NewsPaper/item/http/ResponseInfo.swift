//
//  ResponseInfo.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

struct ResponseInfo {
    var status: String
    
    var totalResults: String?
    var code: String?
    var message: String?
    
    var articles: [NewsItem]?
}
