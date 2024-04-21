//
//  DataManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/21/24.
//

import UIKit
import RealmSwift

class DataManager {
    private var realmObject: Realm?
    
    init() {
        do {
            let config = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: nil,
                deleteRealmIfMigrationNeeded: true
            )
            
            realmObject = try Realm(configuration: config)
        } catch {
            realmObject = nil
        }
    }
    
    func readLocalNewsData() -> [LocalNewsItem] {
        var localData: [LocalNewsItem] = []
        if let rm = realmObject {
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
        if let rm = realmObject {
            do {
                if self.readLocalNewsData().count > 0 {
                    // 전체 삭제
                    try rm.write {
                        rm.deleteAll()
                    }
                }
                
                for newsData in newsDatas {
                    let inputData = LocalNewsItem(data: newsData)
                    
                    if let rm = realmObject {
                        try rm.write {
                            rm.add(inputData)
                        }
                    }
                }
            } catch {
                
            }
        }
    }
}
