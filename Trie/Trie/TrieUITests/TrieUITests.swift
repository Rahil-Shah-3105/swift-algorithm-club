//
//  TrieUITests.swift
//  TrieUITests
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import XCTest
import Foundation

class TrieUITests: XCTestCase {

  override func setUp() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering setUp()\n".utf8))
    super.setUp()

    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
	FileHandle.standardError.write(Data("[DEBUG] setUp(): continueAfterFailure → \(continueAfterFailure)\n".utf8))
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
	FileHandle.standardError.write(Data("[WARN] <<< Exiting setUp()\n".utf8))
  }

  override func tearDown() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering tearDown()\n".utf8))
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting tearDown()\n".utf8))
  }

  func testExample() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testExample()\n".utf8))
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testExample()\n".utf8))
  }

}
