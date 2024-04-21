//
//  MainView.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

class MainView: BaseView {

    private var newsVM: NewsViewModel?
    
    override func initView() {
        super.initView()
        
    }
    
    override func initModel() {
        super.initModel()
        
        self.newsVM = NewsViewModel()
        newsVM!.callNewsApi()
    }
}

