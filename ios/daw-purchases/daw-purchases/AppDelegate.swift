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
//        window?.rootViewController = ViewController()
//        window?.rootViewController = TableViewController()
//        window?.rootViewController = R.storyboard.storyboard.instantiateInitialViewController()
        
       Application.shared.configureMainInterface(in: window!)
            
        
//        let rootRoutable = RootRoutable(window: window!)
//
//        // Set Router
//        router = Router(store: store, rootRoutable: rootRoutable) {
//            $0.select {
//                $0.navigationState
//            }
//        }
//
//        // Setup Keyboard Manager
//        IQKeyboardManager.shared.enable = true
//
//        // Start with splash screen (a.k.a Login screen)
//        store.dispatch(ReSwiftRouter.SetRouteAction([RouteNames.search]))
//
        window?.makeKeyAndVisible()
        
        return true
    }
}

