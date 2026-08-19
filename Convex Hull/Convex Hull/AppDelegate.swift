//
//  AppDelegate.swift
//  Convex Hull
//
//  Created by Jaap Wijnen on 19/02/2017.
//  Copyright © 2017 Workmoose. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
	print(">>> Entering application(application=\(application),launchOptions=\(launchOptions))")

        let screenBounds = UIScreen.main.bounds

        window = UIWindow(frame: screenBounds)

		print("application(application=\(application),launchOptions=\(launchOptions)): window → \(window)")
        let viewController = UIViewController()
        viewController.view = View(frame: (window?.frame)!)
        viewController.view.backgroundColor = .white
		print("application(application=\(application),launchOptions=\(launchOptions)): viewController → \(viewController)")

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

		print("<<< Exiting application(application=\(application),launchOptions=\(launchOptions))")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
		print(">>> Entering applicationWillResignActive(application=\(application))")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
		print("<<< Exiting applicationWillResignActive(application=\(application))")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
		print(">>> Entering applicationDidEnterBackground(application=\(application))")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
		print("<<< Exiting applicationDidEnterBackground(application=\(application))")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
		print(">>> Entering applicationWillEnterForeground(application=\(application))")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
		print("<<< Exiting applicationWillEnterForeground(application=\(application))")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
		print(">>> Entering applicationDidBecomeActive(application=\(application))")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		print("<<< Exiting applicationDidBecomeActive(application=\(application))")
    }

    func applicationWillTerminate(_ application: UIApplication) {
		print(">>> Entering applicationWillTerminate(application=\(application))")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		print("<<< Exiting applicationWillTerminate(application=\(application))")
    }

}
