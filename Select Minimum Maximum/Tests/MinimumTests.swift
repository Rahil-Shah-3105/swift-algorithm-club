import XCTest

class MinimumTests: XCTestCase {

  func testMinimumGivenAListContainingOneElement() {
	print(">>> Entering testMinimumGivenAListContainingOneElement()")
    let array = [ 54 ]

    let result = minimum(array)

	print("testMinimumGivenAListContainingOneElement(): result → \(result)")
    XCTAssertEqual(result, 54)
	print("<<< Exiting testMinimumGivenAListContainingOneElement()")
  }

  func testMinimumGivenAListContainingMultipleElementsWithTheSameValue() {
	print(">>> Entering testMinimumGivenAListContainingMultipleElementsWithTheSameValue()")
    let array = [ 2, 16, 2, 16 ]

    let result = minimum(array)

	print("testMinimumGivenAListContainingMultipleElementsWithTheSameValue(): result → \(result)")
    XCTAssertEqual(result, 2)
	print("<<< Exiting testMinimumGivenAListContainingMultipleElementsWithTheSameValue()")
  }

  func testMinimumGivenAListOfOrderedElements() {
	print(">>> Entering testMinimumGivenAListOfOrderedElements()")
    let array = [ 3, 4, 6, 8, 9 ]

    let result = minimum(array)

	print("testMinimumGivenAListOfOrderedElements(): result → \(result)")
    XCTAssertEqual(result, 3)
	print("<<< Exiting testMinimumGivenAListOfOrderedElements()")
  }

  func testMinimumGivenAListOfReverseOrderedElements() {
	print(">>> Entering testMinimumGivenAListOfReverseOrderedElements()")
    let array = [ 9, 8, 6, 4, 3 ]

    let result = minimum(array)

	print("testMinimumGivenAListOfReverseOrderedElements(): result → \(result)")
    XCTAssertEqual(result, 3)
	print("<<< Exiting testMinimumGivenAListOfReverseOrderedElements()")
  }

  func testMinimumGivenAnEmptyList() {
	print(">>> Entering testMinimumGivenAnEmptyList()")
    let array = [Int]()

	print("testMinimumGivenAnEmptyList(): array → \(array)")
	print("testMinimumGivenAnEmptyList(): result → \(result)")
    let result = minimum(array)

    XCTAssertNil(result)
	print("<<< Exiting testMinimumGivenAnEmptyList()")
  }

  func testMinimumMatchesSwiftLibraryGivenARandomList() {
	print(">>> Entering testMinimumMatchesSwiftLibraryGivenARandomList()")
    for _ in 0...10 {
      for n in 1...100 {
        let array = createRandomList(n)

		print("testMinimumMatchesSwiftLibraryGivenARandomList(): array → \(array)")
        let result = minimum(array)

		print("testMinimumMatchesSwiftLibraryGivenARandomList(): result → \(result)")
        XCTAssertEqual(result, array.min())
      }
    }
	print("<<< Exiting testMinimumMatchesSwiftLibraryGivenARandomList()")
  }
}
