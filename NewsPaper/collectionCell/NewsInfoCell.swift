//
//  NewsInfoCell.swift
//  NewsPaper
//
//  Created by 은냥 on 4/21/24.
//

import UIKit

class NewsInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var titleImageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var imgTerms: NSLayoutConstraint!
    
    override func prepareForReuse() {
        titleImageV.image = nil
        titleLabel.text = ""
        dateLabel.text = ""
        contentLabel.text = ""
    }
    
    func initCell(chkVertical: Bool, width: CGFloat, newsData: Any) {
        if let data = newsData as? NewsItem {
            let chkImg = ToolManager().imgUrlCheck(urlString: data.urlToImage)
            if chkImg.status {
                titleImageV.setNewsImg(with: data.urlToImage)
                
                if chkVertical {
                    imgWidth.constant = 300
                    imgHeight.constant = 150
                } else {
                    imgWidth.constant = width
                    imgHeight.constant = width / 2
                }
            } else {
                imgHeight.constant = 0
                imgTerms.constant = 0
            }
            
            titleLabel.text = data.title
            dateLabel.text = data.publishedAt
            contentLabel.text = data.description
        } else if let localData = newsData as? LocalNewsItem {
            let chkImg = ToolManager().imgUrlCheck(urlString: localData.urlToImage)
            if chkImg.status {
                titleImageV.setNewsImg(with: localData.urlToImage)
                
                if chkVertical {
                    imgWidth.constant = 300
                    imgHeight.constant = 150
                } else {
                    imgWidth.constant = width
                    imgHeight.constant = width / 2
                }
            } else {
                imgHeight.constant = 0
                imgTerms.constant = 0
            }
            
            titleLabel.text = localData.title
            dateLabel.text = localData.publishedAt
            contentLabel.text = localData.desc
        }
    }
}
