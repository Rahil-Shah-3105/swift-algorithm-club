import Foundation
import XCTest

private struct Message: Hashable {
  let text: String
  let priority: Int
  
  var hashValue: Int {
    return text.hashValue
  }
  
  static func == (lhs: Message, rhs: Message) -> Bool {
    return lhs.text == rhs.text
  }
  
  static func < (m1: Message, m2: Message) -> Bool {
    return m1.priority < m2.priority
  }
}

class HashedHeapTest: XCTestCase {
  override func setUp() {
	print(">>> Entering setUp()")
    super.setUp()
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	print("<<< Exiting setUp()")
  }
  
  func testEmpty() {
	print(">>> Entering testEmpty()")
    var queue = HashedHeap<Message>(sort: <)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
    XCTAssertNil(queue.remove())
	print("testEmpty(): queue → \(queue)")
	print("<<< Exiting testEmpty()")
  }
  
  func testOneElement() {
	print(">>> Entering testOneElement()")
    var queue = HashedHeap<Message>(sort: <)
    
	print("testOneElement(): queue → \(queue)")
    queue.insert(Message(text: "hello", priority: 100))
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(queue.peek()!.priority, 100)
    
    let result = queue.remove()
    XCTAssertEqual(result!.priority, 100)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
	print("testOneElement(): result → \(result)")
	print("<<< Exiting testOneElement()")
  }
  
  func testTwoElementsInOrder() {
	print(">>> Entering testTwoElementsInOrder()")
    var queue = HashedHeap<Message>(sort: <)
    
	print("testTwoElementsInOrder(): queue → \(queue)")
    queue.insert(Message(text: "hello", priority: 100))
    queue.insert(Message(text: "world", priority: 200))
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 2)
    XCTAssertEqual(queue.peek()!.priority, 100)
    
    let result1 = queue.remove()
    XCTAssertEqual(result1!.priority, 100)
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(queue.peek()!.priority, 200)
    
	print("testTwoElementsInOrder(): result1 → \(result1)")
    let result2 = queue.remove()
    XCTAssertEqual(result2!.priority, 200)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
	print("testTwoElementsInOrder(): result2 → \(result2)")
	print("<<< Exiting testTwoElementsInOrder()")
  }
  
  func testTwoElementsOutOfOrder() {
	print(">>> Entering testTwoElementsOutOfOrder()")
    var queue = HashedHeap<Message>(sort: <)
    
	print("testTwoElementsOutOfOrder(): queue → \(queue)")
    queue.insert(Message(text: "world", priority: 200))
    queue.insert(Message(text: "hello", priority: 100))
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 2)
    XCTAssertEqual(queue.peek()!.priority, 100)
    
    let result1 = queue.remove()
    XCTAssertEqual(result1!.priority, 100)
    XCTAssertFalse(queue.isEmpty)
    XCTAssertEqual(queue.count, 1)
    XCTAssertEqual(queue.peek()!.priority, 200)
    
	print("testTwoElementsOutOfOrder(): result1 → \(result1)")
    let result2 = queue.remove()
    XCTAssertEqual(result2!.priority, 200)
    XCTAssertTrue(queue.isEmpty)
    XCTAssertEqual(queue.count, 0)
    XCTAssertNil(queue.peek())
	print("testTwoElementsOutOfOrder(): result2 → \(result2)")
	print("<<< Exiting testTwoElementsOutOfOrder()")
  }
}
