//
//  AppDelegate.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var application: UIApplication?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        prepareWindow(application: application)
        return true
    }
    
    func prepareWindow(application: UIApplication) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = HomeBuilder().build()

        self.window = window
        self.application = application
        window.makeKeyAndVisible()
    }
    
    


}

