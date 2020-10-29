//
//  AppDelegate.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Set a dummy view controller to satisfy UIKit
           window?.rootViewController = UIViewController()
           
           let rootRoutable = RootRoutable(window: window!)
           
           // Set Router
           router = Router(store: store, rootRoutable: rootRoutable) {
             $0.select {
               $0.navigationState
             }
           }
           
           // Setup Keyboard Manager
           IQKeyboardManager.shared.enable = true
           
           // Start with splash screen (a.k.a Login screen)
           store.dispatch(ReSwiftRouter.SetRouteAction([RouteNames.splash]))
             
           window?.makeKeyAndVisible()
           
           return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

