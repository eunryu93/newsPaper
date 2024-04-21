//
//  LogManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

/**
 # 로그 매니저, 콘솔출력 + 파일로그 관리용
 */
class LogManager {
    /// 기본로그
    class func basicLog(type: LogType, content: Any) {
        #if DEBUG
        print("\(type) - \(content)")
        #endif
    }
}
