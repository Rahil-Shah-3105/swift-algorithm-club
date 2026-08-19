import XCTest

class SelectionSortTests: XCTestCase {
  func testSelectionSort() {
	print(">>> Entering testSelectionSort()")
    checkSortAlgorithm(selectionSort)
	print("<<< Exiting testSelectionSort()")
  }
}
