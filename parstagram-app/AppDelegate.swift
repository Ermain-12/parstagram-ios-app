//
//  AppDelegate.swift
//  parstagram-app
//
//  Created by Ermain Paul on 3/11/22.
//
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UISceneDelegate {
	
	var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Configure Parse pod
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "jNRk1Y6Dr5EgOujEG35VZdAYrzTCILFZJFuja0zI"
            $0.clientKey = "95YVCAyjQfbpOF8OCpred7tUs7r7Eri4Yb1bmQpW"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        if PFUser.current() != nil {
            let main = UIStoryboard(name: "Main", bundle: nil)
            let feedNavigationController = main.instantiateViewController(withIdentifier: "FeedNavigationController")
            window?.rootViewController = feedNavigationController
        }
        return true
    }


    // MARK: UISceneSession Lifecycle


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }


    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly
    // after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}
