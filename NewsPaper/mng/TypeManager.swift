//
//  TypeManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

enum PathType: String {
    case newsMain = "/v2/top-headlines"
}

enum LogType: String {
    case httpCall = "[HttpCall]"
}

/// HTTP 결과 타입, 메시지 및 코드 반환함
enum NativeErrorType {
    /// 불명
    case none
    /// wifi/LTE 오류
    case notConnectIt
    /// method 오류
    case callMethodErr
    ///  URL 오류, 정확한 URL 이 아님
    case urlError
    /// Http 통신 중 오류, 데이터 제대로 못받음
    case httpError
    /// 데이터가 비어있음
    case dataEmpty
    /// JSON  -> NSDic 변환 중 에러
    case jsonError
    /// 결과코드가 빈값임
    case resCodeBlk
    /// 성공
    case httpOK
    
    /// 메시지 및 코드 반환
    func info() -> (code: String, msg: String) {
        switch self {
        case .none:
            return ("-9999", "무선인터넷 접속 오류나 통신사 오류로\n서비스 접속이 지연되고 있습니다.\n잠시 후 다시 이용해 주세요.\n [ code: -9999 ]")
        
        case .notConnectIt:
            return ("9004", "인터넷 접속이 원할하지 않습니다, Wifi 및 데이터 통신 상태를 확인 후 다시 시도해주세요.")
            
        case .callMethodErr:
            return ("9005", "정상적으로 데이터를 가져오지 못했습니다\n개발자에게 문의해주세요\n[ code: 9005 ]")
            
        case .urlError:
            return ("9000", "정상적으로 데이터를 가져오지 못했습니다\n개발자에게 문의해주세요\n[ code: 9000 ]")
            
        case .httpError:
            return ("9001", "정상적으로 데이터를 가져오지 못했습니다\n개발자에게 문의해주세요\n[ code: 9001 ]")
            
        case .dataEmpty:
            return ("9002", "정상적으로 데이터를 가져오지 못했습니다\n개발자에게 문의해주세요\n[ code: 9002 ]")
            
        case .jsonError:
            return ("9003", "정상적으로 데이터를 가져오지 못했습니다\n개발자에게 문의해주세요\n[ code: 9003 ]")
            
        case .resCodeBlk:
            return ("9999", "정상적으로 데이터를 가져오지 못했습니다\n개발자에게 문의해주세요\n[ code: 9999 ]")
            
        case .httpOK:
            return ("0000", "성공")
        }
    }
}
