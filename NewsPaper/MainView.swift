//
//  MainView.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

class MainView: BaseView,CallDelegate {

    override func initView() {
        super.initView()
        
        // 통신 테스트
        let reqParam: NSDictionary = [
            "country": "kr"
        ]
        let reqInfo = RequestInfo(path: .newsMain, method: .get, param: reqParam)
        
        let httpClient = CallManager()
        httpClient.delegate = self
        
        httpClient.call(reqInfo: reqInfo)
    }
    
    override func initModel() {
        super.initModel()
    }
    
    func resultAction(info: ResponseInfo) {
        LogManager.basicLog(type: .httpCall, content: "checkStatus : \(info.status)")
    }
}

