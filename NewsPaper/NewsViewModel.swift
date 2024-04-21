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
    
    func callNewsApi() {
        // 통신 테스트
        let reqParam: NSDictionary = [
            "country": "kr"
        ]
        let reqInfo = RequestInfo(path: .newsMain, method: .get, param: reqParam)
        
        client = CallManager()
        client!.delegate = self
        client!.call(reqInfo: reqInfo)
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
            
            self.showNewsArray.onNext(array)
        } else {
            LogManager.basicLog(type: .httpCall, content: "NO !")
            LogManager.basicLog(type: .httpCall, content: info.code)
            LogManager.basicLog(type: .httpCall, content: info.message)
        }
    }
}
