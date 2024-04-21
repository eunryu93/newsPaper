//
//  AppDelegate.swift
//  NewsPaper
//
//  Created by 은냥 on 4/20/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkCheck.shared.startMonitoring()
        return true
    }
}

