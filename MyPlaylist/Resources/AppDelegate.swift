//
//  AppDelegate.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if AuthService.shared.isSignedIn {
            window.rootViewController = TabBarViewController()
        } else {
            let signInViewController = UINavigationController(rootViewController: SignInViewController())
            signInViewController.navigationBar.prefersLargeTitles = false
            signInViewController.viewControllers.first?.navigationItem.largeTitleDisplayMode = .never
            window.rootViewController = signInViewController
        }
        
        self.window = window
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

