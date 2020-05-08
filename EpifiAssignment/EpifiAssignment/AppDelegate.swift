//
//  AppDelegate.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        self.window?.rootViewController = FlickrFeedViewControllerComposer.getInstance()
        self.window?.makeKeyAndVisible()
        return true
    }
}

