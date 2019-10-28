//
//  AppDelegate.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 28.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var rootController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setup()
        
        return true
    }
}

// MARK: - Setup 🛠
extension AppDelegate {
    func setup() {
        setRootController()
    }
    
    func setRootController() {
        let usersListViewModel = UsersListViewModel()
        let usersListController = UsersListViewController()
        usersListController.viewModel = usersListViewModel
        self.rootController = UINavigationController(rootViewController: usersListController)
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.rootController
        
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
    }
}
