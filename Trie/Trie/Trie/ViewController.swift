//
//  ViewController.swift
//  Trie
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import Cocoa
import Foundation

class ViewController: NSViewController {

  override func viewDidLoad() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering viewDidLoad()\n".utf8))
    super.viewDidLoad()

    // Do any additional setup after loading the view.
	FileHandle.standardError.write(Data("[WARN] <<< Exiting viewDidLoad()\n".utf8))
  }

  override var representedObject: Any? {
    didSet {
      // Update the view, if already loaded.
    }
  }

}
