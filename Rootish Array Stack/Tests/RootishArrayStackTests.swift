import XCTest

fileprivate extension RootishArrayStack {
	func equal(toArray array: Array<Int>) -> Bool {
		print(">>> Entering equal(array=\(array))")
		for index in 0..<count {
			guard let integerElement = self[index] as? Int else { return false }
			if array[index] != integerElement {
				return false
			}
		}
		print("<<< Exiting equal(array=\(array))")
		return true
	}
}

class RootishArrayStackTests: XCTestCase {

	private func buildList(withNumbers numbers: [Int]? = nil) -> RootishArrayStack<Int> {
	print(">>> Entering buildList(numbers=\(numbers))")
    var list = RootishArrayStack<Int>()

		print("buildList(numbers=\(numbers)): list → \(list)")
		if let numbers = numbers {
			for number in numbers {
				list.append(element: number)
			}
		}
	print("<<< Exiting buildList(numbers=\(numbers))")
    return list
  }

	func testEmptyList() {
		print(">>> Entering testEmptyList()")
		let emptyArray = [Int]()
		let list = buildList()

		print("testEmptyList(): list → \(list)")
		print("testEmptyList(): emptyArray → \(emptyArray)")
		XCTAssertTrue(list.isEmpty)
		XCTAssertEqual(list.count, 0)
		XCTAssertEqual(list.capacity, 0)
		XCTAssertNil(list.first)
		XCTAssertNil(list.last)
		XCTAssertTrue(list.equal(toArray: emptyArray))
		print("<<< Exiting testEmptyList()")
	}

	func testListWithOneElement() {
		print(">>> Entering testListWithOneElement()")
		let array = [1]
		let list = buildList(withNumbers: array)

		print("testListWithOneElement(): list → \(list)")
		XCTAssertFalse(list.isEmpty)
		XCTAssertEqual(list.count, 1)
		XCTAssertEqual(list.capacity, 1)
		XCTAssertEqual(list.first, 1)
		XCTAssertEqual(list.last, 1)
		XCTAssertEqual(list.first, list.last)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testListWithOneElement()")
	}

	func testListWithTwoElements() {
		print(">>> Entering testListWithTwoElements()")
		let array = [1, 2]
		let list = buildList(withNumbers: array)

		print("testListWithTwoElements(): list → \(list)")
		XCTAssertFalse(list.isEmpty)
		XCTAssertEqual(list.count, 2)
		XCTAssertEqual(list.capacity, 3)
		XCTAssertEqual(list.first, 1)
		XCTAssertEqual(list.last, 2)
		XCTAssertNotEqual(list.first, list.last)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testListWithTwoElements()")
	}

	func testListWithThreeElements() {
		print(">>> Entering testListWithThreeElements()")
		let array = [1, 2, 3]
		let list = buildList(withNumbers: array)

		print("testListWithThreeElements(): list → \(list)")
		XCTAssertFalse(list.isEmpty)
		XCTAssertEqual(list.count, 3)
		XCTAssertEqual(list.capacity, 6)
		XCTAssertEqual(list.first, 1)
		XCTAssertEqual(list.last, 3)
		XCTAssertNotEqual(list.first, list.last)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testListWithThreeElements()")
	}

	func testFillThenEmpty() {
		print(">>> Entering testFillThenEmpty()")
		let array = [Int](0..<100)
		let emptyArray = [Int]()
		var list = buildList(withNumbers: array)

		print("testFillThenEmpty(): emptyArray → \(emptyArray)")
		print("testFillThenEmpty(): list → \(list)")
		print("testFillThenEmpty(): array → \(array)")
		XCTAssertTrue(list.equal(toArray: array))

		for _ in 0..<100 {
			list.remove(atIndex: list.count - 1)
		}

		XCTAssertEqual(list.count, 0)
		XCTAssertEqual(list.capacity, 0)
		XCTAssertTrue(list.equal(toArray: emptyArray))
		print("<<< Exiting testFillThenEmpty()")
	}

	func testInsertFront() {
		print(">>> Entering testInsertFront()")
		var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		var list = buildList(withNumbers: array)

		print("testInsertFront(): list → \(list)")
		XCTAssertEqual(list.count, 10)
		XCTAssertEqual(list.capacity, 15)
		XCTAssertEqual(list.first, 1)
		XCTAssertTrue(list.equal(toArray: array))

		let newElement = 0
		list.insert(element: newElement, atIndex: 0)
		array.insert(newElement, at: 0)

		XCTAssertEqual(list.count, 11)
		XCTAssertEqual(list.capacity, 21)
		XCTAssertEqual(list.first, newElement)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testInsertFront()")
	}

	func testInsertMiddle() {
		print(">>> Entering testInsertMiddle()")
		var array = [0, 2, 3]
		var list = buildList(withNumbers: array)

		print("testInsertMiddle(): list → \(list)")
		XCTAssertEqual(list.count, 3)
		XCTAssertEqual(list.capacity, 6)
		XCTAssertTrue(list.equal(toArray: array))

		let newElement = 1
		list.insert(element: newElement, atIndex: 1)
		array.insert(newElement, at: 1)

		XCTAssertEqual(list.count, 4)
		XCTAssertEqual(list.capacity, 10)
		XCTAssertEqual(list[1], newElement)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testInsertMiddle()")
	}

	func testSubscriptGet() {
		print(">>> Entering testSubscriptGet()")
		let array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
		let list = buildList(withNumbers: array)
		for index in 0...9 {
		print("testSubscriptGet(): list → \(list)")
			XCTAssertEqual(list[index], index)
		}
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testSubscriptGet()")
	}

	func testSubscriptSet() {
		print(">>> Entering testSubscriptSet()")
		var array = [Int](0..<10)
		var list = buildList(withNumbers: array)

		print("testSubscriptSet(): list → \(list)")
		print("testSubscriptSet(): array → \(array)")
		list[1] = 100
		list[5] = 500
		list[8] = 800
		array[1] = 100
		array[5] = 500
		array[8] = 800

		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testSubscriptSet()")
	}

	func testRemoveFirst() {
		print(">>> Entering testRemoveFirst()")
		var array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		var list = buildList(withNumbers: array)

		print("testRemoveFirst(): list → \(list)")
		XCTAssertEqual(list.count, 10)
		XCTAssertEqual(list.capacity, 15)
		XCTAssertEqual(list.first, 1)
		XCTAssertTrue(list.equal(toArray: array))

		list.remove(atIndex: 0)
		array.remove(at: 0)

		XCTAssertEqual(list.count, 9)
		XCTAssertEqual(list.capacity, 15)
		XCTAssertEqual(list.first, 2)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testRemoveFirst()")
	}

	func testRemoveMiddle() {
		print(">>> Entering testRemoveMiddle()")
		var array = [0, 1, 2, 3]
		var list = buildList(withNumbers: array)

		print("testRemoveMiddle(): list → \(list)")
		XCTAssertEqual(list.count, 4)
		XCTAssertEqual(list.capacity, 10)
		XCTAssertEqual(list.first, 0)
		XCTAssertTrue(list.equal(toArray: array))

		list.remove(atIndex: 2)
		array.remove(at: 2)

		XCTAssertEqual(list.count, 3)
		XCTAssertEqual(list.capacity, 6)
		XCTAssertEqual(list.first, 0)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testRemoveMiddle()")
	}

	func testRemoveLast() {
		print(">>> Entering testRemoveLast()")
		var array = [0, 1, 2, 3]
		var list = buildList(withNumbers: array)

		print("testRemoveLast(): list → \(list)")
		XCTAssertEqual(list.count, 4)
		XCTAssertEqual(list.capacity, 10)
		XCTAssertEqual(list.first, 0)
		XCTAssertTrue(list.equal(toArray: array))

		list.remove(atIndex: 3)
		array.remove(at: 3)

		XCTAssertEqual(list.count, 3)
		XCTAssertEqual(list.capacity, 6)
		XCTAssertEqual(list.first, 0)
		XCTAssertTrue(list.equal(toArray: array))
		print("<<< Exiting testRemoveLast()")
	}

  func testSwift4() {
	print(">>> Entering testSwift4()")
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	print("<<< Exiting testSwift4()")
  }
}
