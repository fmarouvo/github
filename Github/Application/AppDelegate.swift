//
//  AppDelegate.swift
//  Github
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var application: UIApplication?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        prepareWindow(application: application)
        return true
    }
    
    func prepareWindow(application: UIApplication) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: UserListBuilder().build())
        window.rootViewController = LaunchScreenViewController()
        self.window = window
        self.application = application
        window.makeKeyAndVisible()
    }
    
    class func sharedInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
}

