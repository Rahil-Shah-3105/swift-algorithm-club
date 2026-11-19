//
//  AppDelegate.swift
//  Trie
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering applicationDidFinishLaunching(aNotification=\(aNotification))\n".utf8))
    // Insert code here to initialize your application
	FileHandle.standardError.write(Data("[WARN] <<< Exiting applicationDidFinishLaunching(aNotification=\(aNotification))\n".utf8))
  }

  func applicationWillTerminate(_ aNotification: Notification) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering applicationWillTerminate(aNotification=\(aNotification))\n".utf8))
    // Insert code here to tear down your application
	FileHandle.standardError.write(Data("[WARN] <<< Exiting applicationWillTerminate(aNotification=\(aNotification))\n".utf8))
  }

}
