//
//  Tests.swift
//  Tests
//
//  Created by Peter Bødskov on 10/01/17.
//  Copyright © 2017 Swift Algorithm Club. All rights reserved.
//

import XCTest

class TernarySearchTreeTests: XCTestCase {

  let testCount = 30

  func testSwift4() {
	print(">>> Entering testSwift4()")
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	print("<<< Exiting testSwift4()")
  }

  func testCanFindStringInTree() {
	print(">>> Entering testCanFindStringInTree()")
    var testStrings: [(key: String, data: String)] = []
    let treeOfStrings = TernarySearchTree<String>()

	print("testCanFindStringInTree(): treeOfStrings → \(treeOfStrings)")
    for _ in (1...testCount) {
      var randomLength = Int(arc4random_uniform(10))

	print("testCanFindStringInTree(): randomLength → \(randomLength)")
      var key = Utils.shared.randomAlphaNumericString(withLength: randomLength)

	print("testCanFindStringInTree(): key → \(key)")
      while testStrings.contains(where: { $0.key == key}) {
        //That key is taken, so we generate a new one with another length
        randomLength = Int(arc4random_uniform(10))
        key = Utils.shared.randomAlphaNumericString(withLength: randomLength)
      }
      let data = Utils.shared.randomAlphaNumericString(withLength: randomLength)
      //    print("Key: \(key) Data: \(data)")
	print("testCanFindStringInTree(): data → \(data)")

      if key != "" && data != "" {
        testStrings.append((key, data))
        treeOfStrings.insert(data: data, withKey: key)
      }
    }

    for aTest in testStrings {
      let data = treeOfStrings.find(key: aTest.key)
      XCTAssertNotNil(data)
      XCTAssertEqual(data, aTest.data)
    }
	print("<<< Exiting testCanFindStringInTree()")
  }

  func testCanFindNumberInTree() {
	print(">>> Entering testCanFindNumberInTree()")
    var testNums: [(key: String, data: Int)] = []
    let treeOfInts = TernarySearchTree<Int>()
    for _ in (1...testCount) {
	print("testCanFindNumberInTree(): treeOfInts → \(treeOfInts)")
      let randomNum = Int(arc4random_uniform(UInt32.max))
      var randomLength = Int(arc4random_uniform(10))
      var key = Utils.shared.randomAlphaNumericString(withLength: randomLength)
      while testNums.contains(where: { $0.key == key}) {
	print("testCanFindNumberInTree(): randomNum → \(randomNum)")
	print("testCanFindNumberInTree(): randomLength → \(randomLength)")
	print("testCanFindNumberInTree(): key → \(key)")
        //That key is taken, so we generate a new one with another length
        randomLength = Int(arc4random_uniform(10))
        key = Utils.shared.randomAlphaNumericString(withLength: randomLength)
      }

      if key != "" {
        testNums.append((key, randomNum))
        treeOfInts.insert(data: randomNum, withKey: key)
      }
    }

    for aTest in testNums {
      let data = treeOfInts.find(key: aTest.key)
      XCTAssertNotNil(data)
      XCTAssertEqual(data, aTest.data)
    }
	print("testCanFindNumberInTree(): data → \(data)")
	print("<<< Exiting testCanFindNumberInTree()")
  }
}
