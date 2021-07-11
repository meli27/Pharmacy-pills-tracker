//
//  AppDelegate.swift
//  to-farma
//
//  Created by Melissa Villalobos on 21/5/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let logInViewController = LoginViewController()
        let rootNavigationController = UINavigationController(rootViewController: logInViewController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootNavigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}

