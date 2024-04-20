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
        self.initUrlAndKey()
        var requestSession: DataRequest?
        var nativeErr: NativeErrorType?
        
        // 1] URL 정상여부 확인
        var callUrl: URL?
        if let main = self.mainURL, let checkUrl = URL(string: main + reqInfo.path.rawValue) {
            callUrl = checkUrl
        } else {
            nativeErr = NativeErrorType.urlError
        }
        
        // 2] 인터넷 연결여부 확인
        
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
