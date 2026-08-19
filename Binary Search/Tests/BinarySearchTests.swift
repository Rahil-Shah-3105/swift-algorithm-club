import Foundation
import XCTest

class BinarySearchTest: XCTestCase {
  var searchList = [Int]()

  override func setUp() {
	print(">>> Entering setUp()")
    super.setUp()
    for number in 1...500 {
      searchList.append(number)
    }
	print("<<< Exiting setUp()")
  }

  func testEmptyArray() {
	print(">>> Entering testEmptyArray()")
    let array = [Int]()
    let index = binarySearch(array, key: 123)
    XCTAssertNil(index)
	print("testEmptyArray(): array → \(array)")
	print("<<< Exiting testEmptyArray()")
  }

  func testBinarySearch() {
	print(">>> Entering testBinarySearch()")
    for i in 1...100 {
      var array = [Int]()
      for number in 1...i {
	print("testBinarySearch(): array → \(array)")
        array.append(number)
      }
      let randomIndex = Int(arc4random_uniform(UInt32(i)))
      let testValue = array[randomIndex]
	print("testBinarySearch(): randomIndex → \(randomIndex)")

      let index = binarySearch(array, key: testValue)
      XCTAssertNotNil(index)
      XCTAssertEqual(index!, randomIndex)
      XCTAssertEqual(array[index!], testValue)
    }
	print("<<< Exiting testBinarySearch()")
  }

  func testLowerBound() {
	print(">>> Entering testLowerBound()")
    let index = binarySearch(searchList, key: 1)
    XCTAssertNotNil(index)
    XCTAssertEqual(index!, 0)
    XCTAssertEqual(searchList[index!], 1)
	print("<<< Exiting testLowerBound()")
  }

  func testUpperBound() {
	print(">>> Entering testUpperBound()")
    let index = binarySearch(searchList, key: 500)
    XCTAssertNotNil(index)
    XCTAssertEqual(index!, 499)
    XCTAssertEqual(searchList[index!], 500)
	print("<<< Exiting testUpperBound()")
  }

  func testOutOfLowerBound() {
	print(">>> Entering testOutOfLowerBound()")
    let index = binarySearch(searchList, key: 0)
    XCTAssertNil(index)
	print("<<< Exiting testOutOfLowerBound()")
  }

  func testOutOfUpperBound() {
	print(">>> Entering testOutOfUpperBound()")
    let index = binarySearch(searchList, key: 501)
    XCTAssertNil(index)
	print("<<< Exiting testOutOfUpperBound()")
  }
}
