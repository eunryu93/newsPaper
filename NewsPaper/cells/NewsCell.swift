//
//  NewsCell.swift
//  NewsPaper
//
//  Created by 은냥 on 4/21/24.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImageV: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDatelabel: UILabel!
    @IBOutlet weak var newsContent: UILabel!
    @IBOutlet weak var borderV: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.newsImageV.image = nil
        self.newsTitleLabel.text = ""
        self.newsDatelabel.text = ""
        self.newsContent.text = ""
        self.borderV.isHidden = false
    }
    
    func initCell(info: Any) {
        if let callNews = info as? NewsItem {
            newsTitleLabel.text = callNews.title
            newsDatelabel.text = callNews.publishedAt
            newsContent.text = callNews.description
        }
    }
}
