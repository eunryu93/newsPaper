//
//  CallManager.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import Alamofire
import Network

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
        self.setUrlAndKey()
        var nativeErr: NativeErrorType?
        var header: Dictionary<String, String> = [:]
        
        // 1] URL 정상여부 확인
        var callUrl: URL?
        if let main = self.mainURL {
            let bodyUrl = main + reqInfo.path.rawValue
            
            if let comp = URLComponents(string: bodyUrl) {
                var compInfo = comp
                if reqInfo.param.count > 0 {
                    let paramKey = reqInfo.param.allKeys
                    var queryArray: [URLQueryItem] = []
                    
                    for item in paramKey {
                        if let keyString = item as? String, let value = reqInfo.param[item] as? String {
                            queryArray.append(URLQueryItem(name: keyString, value: value))
                        }
                    }
                    
                    // api 키 추가
                    // 헤더 딕셔너리에도 같이 추가
                    if let apiK = self.apiKey {
                        queryArray.append(URLQueryItem(name: "key", value: apiK))
                        
                        header = [
                            "x-api-key": apiK
                        ]
                    }
                    
                    if queryArray.count > 0 {
                        compInfo.queryItems = queryArray
                    }
                }
                
                callUrl = compInfo.url
            }
        }
        
        if callUrl == nil {
            nativeErr = NativeErrorType.urlError
        }
        
        // 2] 인터넷 연결여부 확인
        if !NetworkCheck.shared.isConnected {
            nativeErr = NativeErrorType.notConnectIt
        }
        
        // 3] 호출 method 가 get이 아니면 오류, 과제가 get으로 호출하므로 나머지 오류처리
        if reqInfo.method != .get {
            nativeErr = NativeErrorType.callMethodErr
        }
        
        if nativeErr != nil {
            self.failAction(nativeErr: nativeErr, resInfo: nil)
            return
        }
        
        let session = getSession()
        let req = session.request(callUrl!, method: reqInfo.method, headers: HTTPHeaders(header))
        req.response { resData in
            self.initUrlAndKey()
            
            switch resData.result {
            case .success(let httpData):
                var resInfo: ResponseInfo?
                do {
                    if let checkResData = httpData {
                        let convertInfo = try JSONDecoder().decode(ResponseInfo.self, from: checkResData)
                        resInfo = convertInfo
                    }
                } catch {
                    resInfo = nil
                }
                
                if resInfo != nil {
                    if let del = self.delegate {
                        del.resultAction(info: resInfo!)
                    }
                } else {
                    let emptyErr = NativeErrorType.dataEmpty
                    self.failAction(nativeErr: emptyErr, resInfo: nil)
                }
                break
            case .failure(let error):
                let httpErr = NativeErrorType.httpError
                self.failAction(nativeErr: nil, resInfo: ResponseInfo(status: "no", code: httpErr.info().code, message: httpErr.info().msg))
                break
            }
        }
    }
    
    private func failAction(nativeErr: NativeErrorType?, resInfo: ResponseInfo?) {
        if let del = delegate {
            var resData: ResponseInfo = ResponseInfo(status: "no")
            if let nativeE = nativeErr {
                resData.code = nativeE.info().code
                resData.message = nativeE.info().msg
            } else if let errInfo = resInfo {
                resData = errInfo
            }
            
            del.resultAction(info: resData)
        }
    }
}

final class NetworkCheck{
    static let shared = NetworkCheck()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    // 연결 타입
    enum ConnectionType{
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    // monotior 초기화
    private init(){
        monitor = NWPathMonitor()
    }
    
    // Network Monitoring 시작
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    // Network Monitoring 종료
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    // Network 연결 타입가져오기.
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
}
