//
//  CombSortTests.swift
//  Tests
//
//  Created by theng on 2017-01-09.
//  Copyright © 2017 Swift Algorithm Club. All rights reserved.
//

import XCTest

class CombSortTests: XCTestCase {
  var sequence: [Int]!
  let expectedSequence: [Int] = [-12, -10, -1, 2, 9, 32, 55, 67, 89, 101]
    
  override func setUp() {
	print(">>> Entering setUp()")
    super.setUp()
    sequence = [2, 32, 9, -1, 89, 101, 55, -10, -12, 67]
	print("setUp(): sequence → \(sequence)")
	print("<<< Exiting setUp()")
  }

  override func tearDown() {
	print(">>> Entering tearDown()")
    super.tearDown()
	print("<<< Exiting tearDown()")
  }

  func testCombSort() {
	print(">>> Entering testCombSort()")
    let sortedSequence = combSort(sequence)
    XCTAssertEqual(sortedSequence, expectedSequence)
	print("testCombSort(): sortedSequence → \(sortedSequence)")
	print("<<< Exiting testCombSort()")
  }
}
