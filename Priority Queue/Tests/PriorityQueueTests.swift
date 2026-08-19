import Foundation
import XCTest

private struct Message {
  let text: String
  let priority: Int
}

private func < (m1: Message, m2: Message) -> Bool {
  return m1.priority < m2.priority
}

class PriorityQueueTest: XCTestCase {
  func testSwift4() {
	print(">>> Entering testSwift4()")
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	print("<<< Exiting testSwift4()")
  }
  
  func testEmpty() {
	print(">>> Entering testEmpty()")
    var queue = PriorityQueue<Message>(sort: <)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
    XCTAssertNil(queue.dequeue())
	print("testEmpty(): queue → \(queue)")
	print("<<< Exiting testEmpty()")
  }

  func testOneElement() {
	print(">>> Entering testOneElement()")
    var queue = PriorityQueue<Message>(sort: <)

	print("testOneElement(): queue → \(queue)")
    queue.enqueue(Message(text: "hello", priority: 100))
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(queue.peek()!.priority, 100)

    let result = queue.dequeue()
    XCTAssertEqual(result!.priority, 100)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
	print("testOneElement(): result → \(result)")
	print("<<< Exiting testOneElement()")
  }

  func testTwoElementsInOrder() {
	print(">>> Entering testTwoElementsInOrder()")
    var queue = PriorityQueue<Message>(sort: <)

	print("testTwoElementsInOrder(): queue → \(queue)")
    queue.enqueue(Message(text: "hello", priority: 100))
    queue.enqueue(Message(text: "world", priority: 200))
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 2)
    XCTAssertEqual(queue.peek()!.priority, 100)

    let result1 = queue.dequeue()
    XCTAssertEqual(result1!.priority, 100)
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(queue.peek()!.priority, 200)

	print("testTwoElementsInOrder(): result1 → \(result1)")
    let result2 = queue.dequeue()
    XCTAssertEqual(result2!.priority, 200)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
	print("testTwoElementsInOrder(): result2 → \(result2)")
	print("<<< Exiting testTwoElementsInOrder()")
  }

  func testTwoElementsOutOfOrder() {
	print(">>> Entering testTwoElementsOutOfOrder()")
    var queue = PriorityQueue<Message>(sort: <)

	print("testTwoElementsOutOfOrder(): queue → \(queue)")
    queue.enqueue(Message(text: "world", priority: 200))
    queue.enqueue(Message(text: "hello", priority: 100))
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 2)
    XCTAssertEqual(queue.peek()!.priority, 100)

    let result1 = queue.dequeue()
    XCTAssertEqual(result1!.priority, 100)
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(queue.peek()!.priority, 200)

	print("testTwoElementsOutOfOrder(): result1 → \(result1)")
    let result2 = queue.dequeue()
    XCTAssertEqual(result2!.priority, 200)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
	print("testTwoElementsOutOfOrder(): result2 → \(result2)")
	print("<<< Exiting testTwoElementsOutOfOrder()")
  }
}
