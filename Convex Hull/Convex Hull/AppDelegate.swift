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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering application(application=\(application),launchOptions=\(launchOptions))\n".utf8))

        let screenBounds = UIScreen.main.bounds

        window = UIWindow(frame: screenBounds)

		FileHandle.standardError.write(Data("[DEBUG] application(application=\(application),launchOptions=\(launchOptions)): window → \(window)\n".utf8))
        let viewController = UIViewController()
        viewController.view = View(frame: (window?.frame)!)
        viewController.view.backgroundColor = .white
		FileHandle.standardError.write(Data("[ERROR] application(application=\(application),launchOptions=\(launchOptions)): viewController → \(viewController)\n".utf8))

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

		FileHandle.standardError.write(Data("[WARN] <<< Exiting application(application=\(application),launchOptions=\(launchOptions))\n".utf8))
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering applicationWillResignActive(application=\(application))\n".utf8))
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
		FileHandle.standardError.write(Data("[WARN] <<< Exiting applicationWillResignActive(application=\(application))\n".utf8))
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering applicationDidEnterBackground(application=\(application))\n".utf8))
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
		FileHandle.standardError.write(Data("[WARN] <<< Exiting applicationDidEnterBackground(application=\(application))\n".utf8))
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering applicationWillEnterForeground(application=\(application))\n".utf8))
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
		FileHandle.standardError.write(Data("[WARN] <<< Exiting applicationWillEnterForeground(application=\(application))\n".utf8))
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering applicationDidBecomeActive(application=\(application))\n".utf8))
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		FileHandle.standardError.write(Data("[WARN] <<< Exiting applicationDidBecomeActive(application=\(application))\n".utf8))
    }

    func applicationWillTerminate(_ application: UIApplication) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering applicationWillTerminate(application=\(application))\n".utf8))
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		FileHandle.standardError.write(Data("[WARN] <<< Exiting applicationWillTerminate(application=\(application))\n".utf8))
    }

}
