//
//  MainView.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import RxSwift

class MainView: BaseView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contentV: UITableView!
    
    private var newsVM: NewsViewModel?
    private var newsBag: DisposeBag = DisposeBag()
    private var newsArray: [Any] = []
    
    override func initView() {
        super.initView()
        
        contentV.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
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
    
    /** UITableView */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell {
            if self.newsArray.count > 0 {
                cell.initCell(info: newsArray[indexPath.row])
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

