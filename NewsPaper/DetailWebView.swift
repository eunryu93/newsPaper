//
//  DetailWebView.swift
//  NewsPaper
//
//  Created by 은냥 on 4/21/24.
//

import UIKit
import WebKit
import EDToolKit

class DetailWebView: BaseView {
    
    @IBOutlet weak var naviBar: CommonNavigationBar!
    
    private var webView: WKWebView?
    private var webLoadCheck: Bool = true
    private let safeKit: SafeLayoutManager = SafeLayoutManager.shared
    var loadUrl: String?
    
    override func initView() {
        super.initView()
        
        let leftBtnInfo = NaviBtnInfo(btnImg: UIImage(resource: .navBtnClose)) {
            self.dismiss(animated: true)
        }
        let naviInfo = NaviInfo(navTitle: "기사보기", navType: .onlyLeft, leftBtnInfo: leftBtnInfo)
        naviBar.setNavigation(info: naviInfo)
        
        if let urlCheck = loadUrl, let load = URL(string: urlCheck) {
            // 웹뷰 생성
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            webView!.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(webView!)
            
            safeKit.basicLayout(left: 0, right: 0, targetView: webView!, baseView: self.view)
            safeKit.singleLayout(type: .bottom, value: 0, targetView: webView!, baseView: self.view)
            AutoLayoutKit.shared.setViewTerm(0, topView: naviBar, bottomView: webView!, mainView: self.view)
            webView!.load(URLRequest(url: load))
        } else {
            webLoadCheck = false
        }
    }
    
    override func initModel() {
        super.initModel()
        
        // webload 가 false 인 경우, 알럿 띄우고 닫기
        if !webLoadCheck {
            let alertCT = UIAlertController(title: "알림", message: "정상적인 웹 주소가 아닙니다. 개발자에게 문의해주세요.", preferredStyle: .alert)
            alertCT.addAction(UIAlertAction(title: "확인", style: .default, handler: { alert in
                self.dismiss(animated: true)
            }))
            self.present(alertCT, animated: true)
        }
    }
}
