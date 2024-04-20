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
}
