//
//  Extensions.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import Kingfisher

/// 딕셔너리 익스텐션 모음
extension NSDictionary {
    
    /// String 공백 확인
    func checkBlankStringValue(key: String, defStr: String) -> String {
        var value = ""
        
        if !"".elementsEqual(defStr) {
            value = defStr
        }
        
        if self.value(forKey: key) != nil && self.value(forKey: key) as? String != nil {
            value = self.value(forKey: key) as! String
        }
        
        // <null> 로 오면 빈값처리
        if "<null>".elementsEqual(value) {
            value = ""
        }
        
        return value
    }
    
    /// boolean 변환
    func checkBool(key: String, defBool: Bool, trueString: String) -> Bool {
        var value: Bool = defBool
        let valueStr = self.checkBlankStringValue(key: key, defStr: "")
        
        if !"".elementsEqual(valueStr) {
            if trueString.elementsEqual(valueStr) {
                value = true
            } else {
                value = false
            }
        }
        
        return value
    }
    
    /// 인티져 변환
    func checkBlankInteger(key: String) -> Int {
        var value = 0
        
        if self.value(forKey: key) != nil && self.value(forKey: key) as? Int != nil {
            value = self.value(forKey: key) as! Int
        }
        
        return value
    }
    
    /// 딕셔너리 변환 및 공백확인
    func checkBlankDictionary(key: String) -> NSDictionary {
        var value: NSDictionary = [:]
        
        if self.value(forKey: key) != nil && self.value(forKey: key) as? NSDictionary != nil {
            value = self.value(forKey: key) as! NSDictionary
        }
        
        return value
    }
    
    /// array 변환 및 공백여부 확인
    func checkBlankArray(key: String) -> NSArray {
        var value: NSArray = []
        
        if self.value(forKey: key) != nil && self.value(forKey: key) as? NSArray != nil {
            value = self.value(forKey: key) as! NSArray
        }
        
        return value
    }
}

extension UIImageView {
    func setNewsImg(with urlString: String?) {
        if urlString == nil {
            return
        }
        
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString!, options: nil) { result in // 캐시에서 키를 통해 이미지를 가져온다.
            switch result {
            case .success(let value):
                if let image = value.image { // 만약 캐시에 이미지가 존재한다면
                    self.image = image // 바로 이미지를 셋한다.
                } else {
                    if NetworkCheck.shared.isConnected {
                        guard let url = URL(string: urlString!) else { return }
                        let resource = ImageResource(downloadURL: url, cacheKey: urlString) // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                        self.kf.setImage(with: resource) // 이미지를 셋한다.
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
