//
//  RequestInfo.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit
import Alamofire

struct RequestInfo {
    var path: PathType
    var method: HTTPMethod
    var param: NSDictionary
}
