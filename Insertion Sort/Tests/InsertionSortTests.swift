import XCTest

class InsertionSortTests: XCTestCase {
  func testInsertionSort() {
	print(">>> Entering testInsertionSort()")
    checkSortAlgorithm(insertionSort)
	print("<<< Exiting testInsertionSort()")
  }
}
