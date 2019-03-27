//
//  AppDelegate.swift
//  MultiProgressViewTestHostApp
//
//  Created by Mac Gallagher on 3/8/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        return true
    }
}
