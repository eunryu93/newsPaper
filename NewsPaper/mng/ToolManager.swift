//
//  ToolManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

class ToolManager {
    func checkHttpResult(status: String) -> Bool {
        if "no".elementsEqual(status) {
            return false
        }
        
        return true
    }
    
    func imgUrlCheck(urlString: String?) -> (status: Bool, url: URL?) {
        var status = false
        var finalUrl: URL?
        
        if let urlStr = urlString {
            // 앞에 네글자 확인, http여부, 정상적인 주소인지 확인
            let prefix = urlStr.prefix(4)
            if "http".elementsEqual(prefix) && URL(string: urlStr) != nil {
                finalUrl = URL(string: urlStr)
                status = true
            }
        }
        
        return (status, finalUrl)
    }
}
