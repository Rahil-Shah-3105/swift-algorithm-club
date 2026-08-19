//
//  Array2DTest.swift
//  algorithmclub
//
//  Created by Barbara Rodeker on 2/16/16.
//  Copyright © 2016 Swift Algorithm Club. All rights reserved.
//

import XCTest

class Array2DTest: XCTestCase {

  override func setUp() {
	print(">>> Entering setUp()")
    super.setUp()
	print("<<< Exiting setUp()")
  }

  override func tearDown() {
	print(">>> Entering tearDown()")
    super.tearDown()
	print("<<< Exiting tearDown()")
  }

  func testIntegerArrayWithPositiveRowsAndColumns() {
	print(">>> Entering testIntegerArrayWithPositiveRowsAndColumns()")
    let array = Array2D<Int>(columns: 3, rows: 2, initialValue: 0)

	print("testIntegerArrayWithPositiveRowsAndColumns(): array → \(array)")
    XCTAssertEqual(array.columns, 3, "Column count setup failed")
    XCTAssertEqual(array.rows, 2, "Rows count setup failed")
    XCTAssertEqual(array[2, 1], 0, "Integer array: Initialization value is wrong")
	print("<<< Exiting testIntegerArrayWithPositiveRowsAndColumns()")
  }

  func testStringArrayWithPositiveRowsAndColumns() {
	print(">>> Entering testStringArrayWithPositiveRowsAndColumns()")
    let array = Array2D<String>(columns: 3, rows: 2, initialValue: "empty")

	print("testStringArrayWithPositiveRowsAndColumns(): array → \(array)")
    XCTAssertEqual(array.columns, 3, "Column count setup failed")
    XCTAssertEqual(array.rows, 2, "Rows count setup failed")
    XCTAssertEqual(array[2, 1], "empty", "String array: Initialization value is wrong")
	print("<<< Exiting testStringArrayWithPositiveRowsAndColumns()")
  }

  func testCustomClassArrayWithPositiveRowsAndColumns() {
	print(">>> Entering testCustomClassArrayWithPositiveRowsAndColumns()")
    let array = Array2D<TestElement>(columns: 3, rows: 2, initialValue: TestElement(identifier: "pepe"))

	print("testCustomClassArrayWithPositiveRowsAndColumns(): array → \(array)")
    XCTAssertEqual(array.columns, 3, "Column count setup failed")
    XCTAssertEqual(array.rows, 2, "Rows count setup failed")
    XCTAssertEqual(array[2, 1], TestElement(identifier: "pepe"), "Custom Class array: Initialization value is wrong")
	print("<<< Exiting testCustomClassArrayWithPositiveRowsAndColumns()")
  }

  func testPerformanceOnSmallArray() {
	print(">>> Entering testPerformanceOnSmallArray()")
    self.measure {
      self.printArrayWith(columns: 2, rows: 2, inititalValue: 1)
    }
	print("<<< Exiting testPerformanceOnSmallArray()")
  }

  //    func testPerformanceOnLargeArray() {
  //        self.measureBlock {
  //            self.printArrayWith(columns: 2000, rows: 2000, inititalValue: 1)
  //        }
  //    }

  fileprivate func printArrayWith(columns: Int, rows: Int, inititalValue: Int) {
	print(">>> Entering printArrayWith(columns=\(columns),rows=\(rows),inititalValue=\(inititalValue))")
    let array = Array2D(columns: columns, rows: rows, initialValue: 4)
    for r in 0..<array.rows {
	print("printArrayWith(columns=\(columns),rows=\(rows),inititalValue=\(inititalValue)): array → \(array)")
      for c in 0..<array.columns {
        print("Array in [\(r), \(c)] value is: \(array[c, r])")
      }
    }
	print("<<< Exiting printArrayWith(columns=\(columns),rows=\(rows),inititalValue=\(inititalValue))")
  }

}

class TestElement: Equatable {
  let identifier: String

  init(identifier: String) {
    self.identifier = identifier
  }
}

func == (lhs: TestElement, rhs: TestElement) -> Bool {
  return lhs.identifier == rhs.identifier
}
