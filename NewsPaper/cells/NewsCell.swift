//
//  NewsCell.swift
//  NewsPaper
//
//  Created by 은냥 on 4/21/24.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImageV: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDatelabel: UILabel!
    @IBOutlet weak var newsContent: UILabel!
    @IBOutlet weak var borderV: UIView!
    
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var imgTerms: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImageV.image = nil
        newsTitleLabel.text = ""
        newsDatelabel.text = ""
        newsContent.text = ""
        borderV.isHidden = false
        
        imgHeight.constant = 150
        imgTerms.constant = 20
    }
    
    func initCell(info: Any) {
        if let callNews = info as? NewsItem {
            let chkImg = ToolManager().imgUrlCheck(urlString: callNews.urlToImage)
            if chkImg.status {
                newsImageV.setNewsImg(with: callNews.urlToImage!)
            } else {
                imgHeight.constant = 0
                imgTerms.constant = 0
            }
            
            newsTitleLabel.text = callNews.title
            newsDatelabel.text = callNews.publishedAt
            newsContent.text = callNews.description
        }
    }
}
