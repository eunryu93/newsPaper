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
    var changeReadTagAct: PublishSubject<Any> = PublishSubject()
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
    
    func changeReadTag(item: Any) {
        if let news = item as? NewsItem {
            DataManager().addReadTitles(readTitle: news.title)
            
            var nw = news
            nw.readCheck = true
            self.changeReadTagAct.onNext(nw)
        } else if let localNews = item as? LocalNewsItem {
            DataManager().addReadTitles(readTitle: localNews.title)
            
            var ln = localNews
            ln.readCheck = true
            self.changeReadTagAct.onNext(ln)
        }
    }
    
    /** Call Delegate */
    func resultAction(info: ResponseInfo) {
        self.client!.delegate = nil
        self.client = nil
        
        if ToolManager().checkHttpResult(status: info.status) {
            var array: [NewsItem] = []
            if let articles = info.articles {
                array = articles
                
                // 읽은 것 확인
                let readTitles = DataManager().getReadTitles()
                if readTitles.count > 0 {
                    for cnt in 0...(array.count - 1) {
                        var it = array[cnt]
                        it.readCheck = false
                        
                        for title in readTitles {
                            if title.elementsEqual(it.title) {
                                it.readCheck = true
                                break
                            }
                        }
                        
                        array[cnt] = it
                    }
                }
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
