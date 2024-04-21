//
//  BaseView.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import EDToolKit

class BaseView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LogManager.basicLog(type: .httpCall, content: "Check Orientation : \(UIDevice.current.orientation.isPortrait)")
        LogManager.basicLog(type: .httpCall, content: "Check Orientation : \(UIDevice.current.orientation.isLandscape)")
        
        self.initModel()
    }
    
    /** open function */
    func initView() {
        
    }
    
    func initModel() {
        
    }
}
