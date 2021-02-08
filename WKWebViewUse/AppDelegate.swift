//
//  AppDelegate.swift
//  WKWebViewUse
//
//  Created by 张君君 on 2021/2/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        window?.rootViewController = UINavigationController(rootViewController: ZJRootViewController())
        
        window?.makeKeyAndVisible()
        return true
    }

}

