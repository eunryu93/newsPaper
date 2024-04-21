//
//  MainView.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import RxSwift

class MainView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var contentV: UICollectionView!
    
    private var newsVM: NewsViewModel?
    private var newsBag: DisposeBag = DisposeBag()
    private var newsArray: [Any] = []
    
    private var isVertical: Bool = true
    
    override func initView() {
        super.initView()
        
        contentV.register(UINib(nibName: "NewsInfoCell", bundle: nil), forCellWithReuseIdentifier: "NewsInfoCell")
        contentV.delegate = self
        contentV.dataSource = self
    }
    
    override func initModel() {
        super.initModel()
        
        newsVM = NewsViewModel()
        newsVM!.showNewsArray.subscribe { itemEle in
            if let itemCheck = itemEle.element {
                self.newsArray = itemCheck
                
                DispatchQueue.main.async {
                    self.contentV.reloadData()
                }
            }
        }.disposed(by: newsBag)
        newsVM!.callNewsApi()
    }
    
    /** orientation */
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        isVertical = UIDevice.current.orientation.isPortrait
        
        DispatchQueue.main.async {
            self.contentV.reloadData()
        }
    }
    
    /** CollectionView Delegate */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsInfoCell", for: indexPath) as? NewsInfoCell {
            var cellWidth: CGFloat = 0
            if isVertical {
                cellWidth = self.view.frame.width
            } else {
                let chkWidth = collectionView.frame.width
                cellWidth = (chkWidth - 20) / 3
            }
            cell.initCell(chkVertical: isVertical, width: cellWidth, newsData: newsArray[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isVertical {
            return CGSize(width: self.view.frame.width, height: self.calculateCellHeight(data: newsArray[indexPath.row], width: self.view.frame.width))
        }
        
        let cellWidth = (collectionView.frame.width - 20) / 3
        return CGSize(width: cellWidth, height: self.calculateCellHeight(data: newsArray[indexPath.row], width: cellWidth))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if isVertical {
            return 10
        }
        
        return 5
    }
    
    func calculateCellHeight(data: Any, width: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        if isVertical {
            if let data = data as? NewsItem {
                let chkImg = ToolManager().imgUrlCheck(urlString: data.urlToImage)
                if chkImg.status {
                    height = 290
                } else {
                    height = 130
                }
            }
        } else {
            if let data = data as? NewsItem {
                let chkImg = ToolManager().imgUrlCheck(urlString: data.urlToImage)
                if chkImg.status {
                    height = (width / 2) + 140
                } else {
                    height = 140
                }
            }
        }
        
        return height
    }
}
