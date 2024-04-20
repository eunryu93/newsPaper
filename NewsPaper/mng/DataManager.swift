//
//  DataManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/21/24.
//

import UIKit
import RealmSwift

class DataManager {
    private var realmObjcect: Realm?
    
    init() {
        do {
            realmObjcect = try Realm()
        } catch {
            realmObjcect = nil
        }
    }
    
    func readLocalNewsData() -> [LocalNewsItem] {
        var localData: [LocalNewsItem] = []
        if let rm = realmObjcect {
            let getRmData = rm.objects(LocalNewsItem.self)
            if !getRmData.isEmpty {
                for item in getRmData {
                    localData.append(item)
                }
            }
        }
        
        return localData
    }
    
    func setNewsData(newsDatas: [NewsItem]) {
        if self.readLocalNewsData().isEmpty {
            LogManager.basicLog(type: .httpCall, content: "데이터 없어서 저장함!")
            for newsData in newsDatas {
                let inputData = LocalNewsItem(data: newsData)
                
                if let rm = realmObjcect {
                    do {
                        try rm.write {
                            rm.add(inputData)
                        }
                    } catch {
                        
                    }
                }
            }
        } else {
            LogManager.basicLog(type: .httpCall, content: "데이터 있어서 저장안함!")
        }
    }
}
