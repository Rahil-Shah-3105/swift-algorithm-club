import XCTest

class MinimumMaximumPairsTests: XCTestCase {

  func testMinimumAndMaximumGivenAListContainingOneElement() {
	print(">>> Entering testMinimumAndMaximumGivenAListContainingOneElement()")
    let array = [ 8 ]

    let result = minimumMaximum(array)!
	print("testMinimumAndMaximumGivenAListContainingOneElement(): result → \(result)")

    XCTAssertEqual(result.minimum, 8)
    XCTAssertEqual(result.maximum, 8)
	print("<<< Exiting testMinimumAndMaximumGivenAListContainingOneElement()")
  }

  func testMinimumAndMaximumGivenAListContainingMultipleElementsWithTheSameValue() {
	print(">>> Entering testMinimumAndMaximumGivenAListContainingMultipleElementsWithTheSameValue()")
    let array = [ 8, 16, 8, 8 ]

    let result = minimumMaximum(array)!
	print("testMinimumAndMaximumGivenAListContainingMultipleElementsWithTheSameValue(): result → \(result)")

    XCTAssertEqual(result.minimum, 8)
    XCTAssertEqual(result.maximum, 16)
	print("<<< Exiting testMinimumAndMaximumGivenAListContainingMultipleElementsWithTheSameValue()")
  }

  func testMimimumAndMaximumGivenAListContainingAnEvenNumberOfElements() {
	print(">>> Entering testMimimumAndMaximumGivenAListContainingAnEvenNumberOfElements()")
    let array = [ 3, 4, 6, 8 ]

    let result = minimumMaximum(array)!
	print("testMimimumAndMaximumGivenAListContainingAnEvenNumberOfElements(): result → \(result)")

    XCTAssertEqual(result.minimum, 3)
    XCTAssertEqual(result.maximum, 8)
	print("<<< Exiting testMimimumAndMaximumGivenAListContainingAnEvenNumberOfElements()")
  }

  func testMimimumAndMaximumGivenAListContainingAnOddNumberOfElements() {
	print(">>> Entering testMimimumAndMaximumGivenAListContainingAnOddNumberOfElements()")
    let array = [ 8, 3, 9, 4, 6 ]

    let result = minimumMaximum(array)!
	print("testMimimumAndMaximumGivenAListContainingAnOddNumberOfElements(): result → \(result)")

    XCTAssertEqual(result.minimum, 3)
    XCTAssertEqual(result.maximum, 9)
	print("<<< Exiting testMimimumAndMaximumGivenAListContainingAnOddNumberOfElements()")
  }

  func testMimimumAndMaximumGivenAListOfOrderedElements() {
	print(">>> Entering testMimimumAndMaximumGivenAListOfOrderedElements()")
    let array = [ 3, 4, 6, 8, 9 ]

    let result = minimumMaximum(array)!
	print("testMimimumAndMaximumGivenAListOfOrderedElements(): result → \(result)")

    XCTAssertEqual(result.minimum, 3)
    XCTAssertEqual(result.maximum, 9)
	print("<<< Exiting testMimimumAndMaximumGivenAListOfOrderedElements()")
  }

  func testMimimumAndMaximumGivenAListOfReverseOrderedElements() {
	print(">>> Entering testMimimumAndMaximumGivenAListOfReverseOrderedElements()")
    let array = [ 9, 8, 6, 4, 3 ]

    let result = minimumMaximum(array)!
	print("testMimimumAndMaximumGivenAListOfReverseOrderedElements(): result → \(result)")

    XCTAssertEqual(result.minimum, 3)
    XCTAssertEqual(result.maximum, 9)
	print("<<< Exiting testMimimumAndMaximumGivenAListOfReverseOrderedElements()")
  }

  func testMinimumAndMaximumGivenAnEmptyList() {
	print(">>> Entering testMinimumAndMaximumGivenAnEmptyList()")
    let array = [Int]()

	print("testMinimumAndMaximumGivenAnEmptyList(): array → \(array)")
	print("testMinimumAndMaximumGivenAnEmptyList(): result → \(result)")
    let result = minimumMaximum(array)

    XCTAssertNil(result)
	print("<<< Exiting testMinimumAndMaximumGivenAnEmptyList()")
  }

  func testMinimumAndMaximumMatchSwiftLibraryGivenARandomList() {
	print(">>> Entering testMinimumAndMaximumMatchSwiftLibraryGivenARandomList()")
    for _ in 0...10 {
      for n in 1...100 {
        let array = createRandomList(n)

		print("testMinimumAndMaximumMatchSwiftLibraryGivenARandomList(): array → \(array)")
        let result = minimumMaximum(array)!
		print("testMinimumAndMaximumMatchSwiftLibraryGivenARandomList(): result → \(result)")

        XCTAssertEqual(result.minimum, array.min())
        XCTAssertEqual(result.maximum, array.max())
      }
    }
	print("<<< Exiting testMinimumAndMaximumMatchSwiftLibraryGivenARandomList()")
  }
}
