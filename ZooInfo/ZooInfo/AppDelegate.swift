//
//  AppDelegate.swift
//  ZooInfo
//
//  Created by YomiRY on 2023/11/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

