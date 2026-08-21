//
//  AppDelegate.swift
//  Trie
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
	print(">>> Entering applicationDidFinishLaunching(aNotification=\(aNotification))")
    // Insert code here to initialize your application
	print("<<< Exiting applicationDidFinishLaunching(aNotification=\(aNotification))")
  }

  func applicationWillTerminate(_ aNotification: Notification) {
	print(">>> Entering applicationWillTerminate(aNotification=\(aNotification))")
    // Insert code here to tear down your application
	print("<<< Exiting applicationWillTerminate(aNotification=\(aNotification))")
  }

}
