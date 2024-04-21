//
//  NewsViewModel.swift
//  NewsPaper
//
//  Created by 은냥 on 4/21/24.
//

import UIKit
import RxSwift

class NewsViewModel: CallDelegate {
    
    var showNewsArray: PublishSubject<[Any]> = PublishSubject()
    private var client: CallManager?
    
    func getNewsData(useLocal: Bool = false) {
        if useLocal {
            self.getLocalData()
        } else {
            if NetworkCheck.shared.isConnected {
                let reqParam: NSDictionary = [
                    "country": "kr"
                ]
                let reqInfo = RequestInfo(path: .newsMain, method: .get, param: reqParam)
                
                client = CallManager()
                client!.delegate = self
                client!.call(reqInfo: reqInfo)
            } else {
                self.getLocalData()
            }
        }
    }
    
    func getLocalData() {
        let localData = DataManager().readLocalNewsData()
        self.showNewsArray.onNext(localData)
    }
    
    /** Call Delegate */
    func resultAction(info: ResponseInfo) {
        self.client!.delegate = nil
        self.client = nil
        
        if ToolManager().checkHttpResult(status: info.status) {
            var array: [NewsItem] = []
            if let articles = info.articles {
                array = articles
            }
            
            if array.count > 0 {
                DataManager().setNewsData(newsDatas: array)
            }
            
            self.showNewsArray.onNext(array)
        } else {
            self.getNewsData(useLocal: true)
        }
    }
}
