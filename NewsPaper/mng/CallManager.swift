//
//  CallManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import Foundation

protocol CallDelegate {
    func resultAction(info: ResponseInfo)
}

class CallManager {
    
    var delegate: CallDelegate?
    
    private var mainURL: String?
    private var apiKey: String?
    
    func setUrlAndKey() {
        mainURL = "https://newsapi.org"
        apiKey = "feb97c455b5f492a8a2155f5c92d6798"
    }
    
    func initUrlAndKey() {
        mainURL = nil
        apiKey = nil
    }
    
    func call() {
        
    }
}
