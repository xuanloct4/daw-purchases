//
//  Application.swift
//  daw-purchases
//
//  Created by Tran Loc on 14/09/2021.
//  Copyright © 2021 Tran Loc. All rights reserved.
//

import UIKit

final class Application {
    static let shared = Application()

    private let coreDataUseCaseProvider: UseCaseProvider
    private let realmUseCaseProvider: UseCaseProvider
    private let networkUseCaseProvider: UseCaseProvider

    private init() {
        self.coreDataUseCaseProvider = CoreDataUseCaseProvider()
        self.realmUseCaseProvider = RealmUseCaseProvider()
        self.networkUseCaseProvider = NetworkUseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cdNavigationController = UINavigationController()
        cdNavigationController.tabBarItem = UITabBarItem(title: "CoreData",
                image: UIImage(named: "Box"),
                selectedImage: nil)
        let cdNavigator = DefaultPostsNavigator(services: coreDataUseCaseProvider,
                navigationController: cdNavigationController,
                storyBoard: storyboard)

        let rmNavigationController = UINavigationController()
        rmNavigationController.tabBarItem = UITabBarItem(title: "Realm",
                image: UIImage(named: "Toolbox"),
                selectedImage: nil)
        let rmNavigator = DefaultPostsNavigator(services: realmUseCaseProvider,
                navigationController: rmNavigationController,
                storyBoard: storyboard)

        let networkNavigationController = UINavigationController()
        networkNavigationController.tabBarItem = UITabBarItem(title: "Network",
                image: UIImage(named: "Toolbox"),
                selectedImage: nil)
        let networkNavigator = DefaultPostsNavigator(services: networkUseCaseProvider,
                navigationController: networkNavigationController,
                storyBoard: storyboard)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
                cdNavigationController,
                rmNavigationController,
                networkNavigationController
        ]
        window.rootViewController = tabBarController

        cdNavigator.toPosts()
        rmNavigator.toPosts()
        networkNavigator.toPosts()
    }
}
