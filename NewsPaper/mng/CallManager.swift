//
//  CallManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import Alamofire

protocol CallDelegate {
    func resultAction(info: ResponseInfo)
}

class CallManager {
    
    var delegate: CallDelegate?
    
    private var mainURL: String?
    private var apiKey: String?
    
    private func setUrlAndKey() {
        mainURL = "https://newsapi.org"
        apiKey = "feb97c455b5f492a8a2155f5c92d6798"
    }
    
    private func initUrlAndKey() {
        mainURL = nil
        apiKey = nil
    }
    
    /// Session 생성함수, 타임아웃 20초로 설정되어 있음
    private func getSession() -> Session {
        let netSession = Session.default
        netSession.sessionConfiguration.timeoutIntervalForRequest = 10
        netSession.sessionConfiguration.timeoutIntervalForResource = 10
        
        return netSession
    }
    
    func call(reqInfo: RequestInfo) {
        self.initUrlAndKey()
        var requestSession: DataRequest?
        var resultInfo: ResponseInfo?
        
        var callUrl = ""
        if let main = self.mainURL, let callUrl = URL(string: main + reqInfo.path.rawValue) {
            
        } else {
            
        }
    }
}
