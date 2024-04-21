//
//  CommonNavigationBar.swift
//  DearMyFriends
//
//  Created by 김현지 on 12/6/23.
//

import UIKit
import EDToolKit

/// 공통 네비바
class CommonNavigationBar: UIView {
    
    private let xibName = "CommonNavigationBar"
    
    /// 왼쪽 버튼
    @IBOutlet weak var leftBtn: UIButton!
    /// 우측버튼
    @IBOutlet weak var rightBtn: UIButton!
    /// 타이틀
    @IBOutlet weak var navTitleLabel: UILabel!
    
    var naviInfo: NaviInfo?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        AutoLayoutKit.shared.setAutoLayout(0, Trailing: 0, Top: 0, Bottom: 0, Width: nil, Height: nil, TargetView: view, MainView: self)
    }
    
    /// 네비게이션 셋팅 함수
    /// 네비 인포 오브젝트 만들어서 넘기면 됨
    func setNavigation(info: NaviInfo) {
        self.naviInfo = info
        
        // 초기화
        leftBtn.isHidden = true
        rightBtn.isHidden = true
        navTitleLabel.text = ""
        
        if let navi = self.naviInfo {
            navTitleLabel.text = navi.navTitle
            
            if (navi.navType == .all || navi.navType == .onlyLeft), let naviBtnInfo = navi.leftBtnInfo  {
                leftBtn.isHidden = false
                leftBtn.setImage(naviBtnInfo.btnImg, for: .normal)
                leftBtn.addTarget(self, action: #selector(naviLeftAction(sender: )), for: .touchUpInside)
            }
            
            if (navi.navType == .all || navi.navType == .onlyRight), let naviBtnInfo = navi.rightBtnInfo  {
                rightBtn.isHidden = false
                rightBtn.setImage(naviBtnInfo.btnImg, for: .normal)
                rightBtn.addTarget(self, action: #selector(naviRightAction(sender: )), for: .touchUpInside)
            }
        }
    }
    
    @objc func naviLeftAction(sender: UIButton) {
        if let navi = naviInfo, let naviBtnInfo = navi.leftBtnInfo {
            naviBtnInfo.action()
        }
    }
    
    @objc func naviRightAction(sender: UIButton) {
        if let navi = naviInfo, let naviBtnInfo = navi.rightBtnInfo {
            naviBtnInfo.action()
        }
    }
}

/// 네비 인포
class NaviInfo {
    /// 네비 타이틀
    var navTitle: String
    /// 네비게이션 타입
    var navType: NaviType
    /// 왼쪽 버튼 인포, 없으면 nil 처리
    var leftBtnInfo: NaviBtnInfo?
    /// 오른쪽 버튼 인포, 없으면 nil처리
    var rightBtnInfo: NaviBtnInfo?
    
    init(navTitle: String, navType: NaviType, leftBtnInfo: NaviBtnInfo? = nil, rightBtnInfo: NaviBtnInfo? = nil) {
        self.navTitle = navTitle
        self.navType = navType
        self.leftBtnInfo = leftBtnInfo
        self.rightBtnInfo = rightBtnInfo
    }
}

/// 네비게이션 버튼 인포
class NaviBtnInfo {
    /// 버튼 이미지
    var btnImg: UIImage
    /// 버튼 액션
    var action: (() -> Void)
    
    init(btnImg: UIImage, action: @escaping () -> Void) {
        self.btnImg = btnImg
        self.action = action
    }
}
