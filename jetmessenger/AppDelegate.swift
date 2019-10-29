//
//  AppDelegate.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var rootController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setup()
        NetworkActivityLogger.shared.startLogging()
        
        return true
    }
}

// MARK: - Setup 🛠
extension AppDelegate {
    func setup() {
        setRootController()
    }
    
    func setRootController() {
        let usersListController = UIStoryboard.get(UsersListViewController.self)
        self.rootController = UINavigationController(rootViewController: usersListController)
        
        let networkService = NetworkImplementation()
        let cacheService = CacheServiceImplementation()
        let dataProvider = DataProviderImplementation(network: networkService, cache: cacheService)
        let usersListViewModel = UsersListViewModel(provider: dataProvider)
        usersListController.viewModel = usersListViewModel
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.rootController
        
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
    }
}
