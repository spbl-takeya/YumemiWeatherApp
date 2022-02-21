//
//  AppDelegate.swift
//  YumemiWeatherApp
//
//  Created by Takeya Shimizu on 2022/01/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("[lifecycle (App)]", #function)
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("[lifecycle (App)]", #function)
        // Override point for customization after application launch.
        return true
    }

    //SceneDelegateがあるとそちら側が呼ばれるので、こちらは呼ばれない
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("[lifecycle (App)]", #function)
    }

    //SceneDelegateがあるとそちら側が呼ばれるので、こちらは呼ばれない
    func applicationWillResignActive(_ application: UIApplication) {
        print("[lifecycle (App)]", #function)
    }

    //SceneDelegateがあるとそちら側が呼ばれるので、こちらは呼ばれない
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("[lifecycle (App)]", #function)
    }

    //SceneDelegateがあるとそちら側が呼ばれるので、こちらは呼ばれない
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("[lifecycle (App)]", #function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("[lifecycle (App)]", #function)
    }

    // UniversalLinkからの起動
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print("[lifecycle (App)]", #function)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("[lifecycle (App)]", #function)
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("[lifecycle (App)]", #function)
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

