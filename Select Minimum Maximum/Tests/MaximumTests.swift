import XCTest

class MaximumTests: XCTestCase {

  func testMaximumGivenAListContainingOneElement() {
	print(">>> Entering testMaximumGivenAListContainingOneElement()")
    let array = [ 99 ]

    let result = maximum(array)

	print("testMaximumGivenAListContainingOneElement(): result → \(result)")
    XCTAssertEqual(result, 99)
	print("<<< Exiting testMaximumGivenAListContainingOneElement()")
  }

  func testMaximumGivenAListContainingMultipleElementsWithTheSameValue() {
	print(">>> Entering testMaximumGivenAListContainingMultipleElementsWithTheSameValue()")
    let array = [ 3, 16, 3, 16 ]

    let result = maximum(array)

	print("testMaximumGivenAListContainingMultipleElementsWithTheSameValue(): result → \(result)")
    XCTAssertEqual(result, 16)
	print("<<< Exiting testMaximumGivenAListContainingMultipleElementsWithTheSameValue()")
  }

  func testMaximumGivenAListOfOrderedElements() {
	print(">>> Entering testMaximumGivenAListOfOrderedElements()")
    let array = [ 3, 4, 6, 8, 9 ]

    let result = maximum(array)

	print("testMaximumGivenAListOfOrderedElements(): result → \(result)")
    XCTAssertEqual(result, 9)
	print("<<< Exiting testMaximumGivenAListOfOrderedElements()")
  }

  func testMaximumGivenAListOfReverseOrderedElements() {
	print(">>> Entering testMaximumGivenAListOfReverseOrderedElements()")
    let array = [ 9, 8, 6, 4, 3 ]

    let result = maximum(array)

	print("testMaximumGivenAListOfReverseOrderedElements(): result → \(result)")
    XCTAssertEqual(result, 9)
	print("<<< Exiting testMaximumGivenAListOfReverseOrderedElements()")
  }

  func testMaximumGivenAnEmptyList() {
	print(">>> Entering testMaximumGivenAnEmptyList()")
    let array = [Int]()

	print("testMaximumGivenAnEmptyList(): array → \(array)")
	print("testMaximumGivenAnEmptyList(): result → \(result)")
    let result = maximum(array)

    XCTAssertNil(result)
	print("<<< Exiting testMaximumGivenAnEmptyList()")
  }

  func testMaximumMatchesSwiftLibraryGivenARandomList() {
	print(">>> Entering testMaximumMatchesSwiftLibraryGivenARandomList()")
    for _ in 0...10 {
      for n in 1...100 {
        let array = createRandomList(n)

		print("testMaximumMatchesSwiftLibraryGivenARandomList(): array → \(array)")
        let result = maximum(array)

		print("testMaximumMatchesSwiftLibraryGivenARandomList(): result → \(result)")
        XCTAssertEqual(result, array.max())
      }
    }
	print("<<< Exiting testMaximumMatchesSwiftLibraryGivenARandomList()")
  }
}
