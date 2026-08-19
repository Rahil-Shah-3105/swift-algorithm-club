import XCTest

class LinkedListTest: XCTestCase {
    let numbers = [8, 2, 10, 9, 7, 5]
    
    fileprivate func buildList() -> LinkedList<Int> {
		print(">>> Entering buildList()")
        let list = LinkedList<Int>()
        for number in numbers {
			print("buildList(): list → \(list)")
            list.append(number)
        }
		print("<<< Exiting buildList()")
        return list
    }
    
    func testSwift4() {
		print(">>> Entering testSwift4()")
        // last checked with Xcode 9.0b4
        #if swift(>=4.0)
            print("Hello, Swift 4!")
        #endif
		print("<<< Exiting testSwift4()")
    }
    
    func testEmptyList() {
		print(">>> Entering testEmptyList()")
        let list = LinkedList<Int>()
        XCTAssertTrue(list.isEmpty)
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
		print("testEmptyList(): list → \(list)")
		print("<<< Exiting testEmptyList()")
    }
    
    func testListWithOneElement() {
		print(">>> Entering testListWithOneElement()")
        let list = LinkedList<Int>()
        list.append(123)
        
		print("testListWithOneElement(): list → \(list)")
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 1)
        
        XCTAssertNotNil(list.first)
        XCTAssertNil(list.head!.previous)
        XCTAssertNil(list.head!.next)
        XCTAssertEqual(list.head!.value, 123)
        
        XCTAssertNotNil(list.last)
        XCTAssertNil(list.last!.previous)
        XCTAssertNil(list.last!.next)
        XCTAssertEqual(list.last!.value, 123)
        
        XCTAssertTrue(list.head === list.last)
		print("<<< Exiting testListWithOneElement()")
    }
    
    func testListWithTwoElements() {
		print(">>> Entering testListWithTwoElements()")
        let list = LinkedList<Int>()
        list.append(123)
        list.append(456)
        
		print("testListWithTwoElements(): list → \(list)")
        XCTAssertEqual(list.count, 2)
        
        XCTAssertNotNil(list.first)
        XCTAssertEqual(list.head!.value, 123)
        
        XCTAssertNotNil(list.last)
        XCTAssertEqual(list.last!.value, 456)
        
        XCTAssertTrue(list.head !== list.last)
        
        XCTAssertNil(list.head!.previous)
        XCTAssertTrue(list.head!.next === list.last)
        XCTAssertTrue(list.last!.previous === list.head)
        XCTAssertNil(list.last!.next)
		print("<<< Exiting testListWithTwoElements()")
    }
    
    func testListWithThreeElements() {
		print(">>> Entering testListWithThreeElements()")
        let list = LinkedList<Int>()
        list.append(123)
        list.append(456)
        list.append(789)
        
		print("testListWithThreeElements(): list → \(list)")
        XCTAssertEqual(list.count, 3)
        
        XCTAssertNotNil(list.first)
        XCTAssertEqual(list.head!.value, 123)
        
        let second = list.head!.next
        XCTAssertNotNil(second)
        XCTAssertEqual(second!.value, 456)
        
        XCTAssertNotNil(list.last)
        XCTAssertEqual(list.last!.value, 789)
        
        XCTAssertNil(list.head!.previous)
        XCTAssertTrue(list.head!.next === second)
        XCTAssertTrue(second!.previous === list.head)
        XCTAssertTrue(second!.next === list.last)
        XCTAssertTrue(list.last!.previous === second)
        XCTAssertNil(list.last!.next)
		print("<<< Exiting testListWithThreeElements()")
    }
    
    func testNodeAtIndexInListWithOneElement() {
		print(">>> Entering testNodeAtIndexInListWithOneElement()")
        let list = LinkedList<Int>()
        list.append(123)
        
		print("testNodeAtIndexInListWithOneElement(): list → \(list)")
        let node = list.node(at: 0)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 123)
        XCTAssertTrue(node === list.head)
		print("testNodeAtIndexInListWithOneElement(): node → \(node)")
		print("<<< Exiting testNodeAtIndexInListWithOneElement()")
    }
    
    func testNodeAtIndex() {
		print(">>> Entering testNodeAtIndex()")
        let list = buildList()
        
		print("testNodeAtIndex(): list → \(list)")
        let nodeCount = list.count
        XCTAssertEqual(nodeCount, numbers.count)
        
        let first = list.node(at: 0)
        XCTAssertNotNil(first)
        XCTAssertTrue(first === list.head)
        XCTAssertEqual(first.value, numbers[0])
        
		print("testNodeAtIndex(): first → \(first)")
        let last = list.node(at: nodeCount - 1)
        XCTAssertNotNil(last)
        XCTAssertTrue(last === list.last)
        XCTAssertEqual(last.value, numbers[nodeCount - 1])
        
		print("testNodeAtIndex(): last → \(last)")
        for i in 0..<nodeCount {
            let node = list.node(at: i)
            XCTAssertNotNil(node)
            XCTAssertEqual(node.value, numbers[i])
        }
			print("testNodeAtIndex(): node → \(node)")
    }
    
    func testSubscript() {
		print(">>> Entering testSubscript()")
        let list = buildList()
        for i in 0 ..< list.count {
			print("testSubscript(): list → \(list)")
            XCTAssertEqual(list[i], numbers[i])
        }
		print("<<< Exiting testSubscript()")
    }
    
    func testInsertAtIndexInEmptyList() {
		print(">>> Entering testInsertAtIndexInEmptyList()")
        let list = LinkedList<Int>()
        list.insert(123, at: 0)
        
		print("testInsertAtIndexInEmptyList(): list → \(list)")
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 1)
        
        let node = list.node(at: 0)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 123)
		print("testInsertAtIndexInEmptyList(): node → \(node)")
		print("<<< Exiting testInsertAtIndexInEmptyList()")
    }
    
    func testInsertAtIndex() {
		print(">>> Entering testInsertAtIndex()")
        let list = buildList()
        let prev = list.node(at: 2)
        let next = list.node(at: 3)
        let nodeCount = list.count
		print("testInsertAtIndex(): prev → \(prev)")
		print("testInsertAtIndex(): next → \(next)")
		print("testInsertAtIndex(): list → \(list)")
        
        list.insert(444, at: 3)
        
        let node = list.node(at: 3)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 444)
        XCTAssertEqual(nodeCount + 1, list.count)
        
		print("testInsertAtIndex(): node → \(node)")
        XCTAssertFalse(prev === node)
        XCTAssertFalse(next === node)
        XCTAssertTrue(prev.next === node)
        XCTAssertTrue(next.previous === node)
		print("<<< Exiting testInsertAtIndex()")
    }
    
    func testInsertListAtIndex() {
		print(">>> Entering testInsertListAtIndex()")
        let list = buildList()
        let list2 = LinkedList<Int>()
        list2.append(99)
        list2.append(102)
        list.insert(list2, at: 2)
        XCTAssertTrue(list.count == 8)
        XCTAssertEqual(list.node(at: 1).value, 2)
        XCTAssertEqual(list.node(at: 2).value, 99)
        XCTAssertEqual(list.node(at: 3).value, 102)
        XCTAssertEqual(list.node(at: 4).value, 10)
		print("testInsertListAtIndex(): list2 → \(list2)")
		print("testInsertListAtIndex(): list → \(list)")
		print("<<< Exiting testInsertListAtIndex()")
    }
    
    func testInsertListAtFirstIndex() {
		print(">>> Entering testInsertListAtFirstIndex()")
        let list = buildList()
        let list2 = LinkedList<Int>()
        list2.append(99)
        list2.append(102)
        list.insert(list2, at: 0)
        XCTAssertTrue(list.count == 8)
        XCTAssertEqual(list.node(at: 0).value, 99)
        XCTAssertEqual(list.node(at: 1).value, 102)
        XCTAssertEqual(list.node(at: 2).value, 8)
		print("testInsertListAtFirstIndex(): list2 → \(list2)")
		print("testInsertListAtFirstIndex(): list → \(list)")
		print("<<< Exiting testInsertListAtFirstIndex()")
    }
    
    func testInsertListAtLastIndex() {
		print(">>> Entering testInsertListAtLastIndex()")
        let list = buildList()
        let list2 = LinkedList<Int>()
        list2.append(99)
        list2.append(102)
        list.insert(list2, at: list.count)
        XCTAssertTrue(list.count == 8)
        XCTAssertEqual(list.node(at: 5).value, 5)
        XCTAssertEqual(list.node(at: 6).value, 99)
        XCTAssertEqual(list.node(at: 7).value, 102)
		print("testInsertListAtLastIndex(): list2 → \(list2)")
		print("testInsertListAtLastIndex(): list → \(list)")
		print("<<< Exiting testInsertListAtLastIndex()")
    }
    
    func testAppendList() {
		print(">>> Entering testAppendList()")
        let list = buildList()
        let list2 = LinkedList<Int>()
        list2.append(99)
        list2.append(102)
        list.append(list2)
        XCTAssertTrue(list.count == 8)
        XCTAssertEqual(list.node(at: 5).value, 5)
        XCTAssertEqual(list.node(at: 6).value, 99)
        XCTAssertEqual(list.node(at: 7).value, 102)
		print("testAppendList(): list2 → \(list2)")
		print("testAppendList(): list → \(list)")
		print("<<< Exiting testAppendList()")
    }
    
    func testAppendListToEmptyList() {
		print(">>> Entering testAppendListToEmptyList()")
        let list = LinkedList<Int>()
        let list2 = LinkedList<Int>()
        list2.append(5)
        list2.append(10)
        list.append(list2)
        XCTAssertTrue(list.count == 2)
        XCTAssertEqual(list.node(at: 0).value, 5)
        XCTAssertEqual(list.node(at: 1).value, 10)
		print("testAppendListToEmptyList(): list2 → \(list2)")
		print("testAppendListToEmptyList(): list → \(list)")
		print("<<< Exiting testAppendListToEmptyList()")
    }
    
    func testRemoveAtIndexOnListWithOneElement() {
		print(">>> Entering testRemoveAtIndexOnListWithOneElement()")
        let list = LinkedList<Int>()
        list.append(123)
        
		print("testRemoveAtIndexOnListWithOneElement(): list → \(list)")
        let value = list.remove(at: 0)
        XCTAssertEqual(value, 123)
        
		print("testRemoveAtIndexOnListWithOneElement(): value → \(value)")
        XCTAssertTrue(list.isEmpty)
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
		print("<<< Exiting testRemoveAtIndexOnListWithOneElement()")
    }
    
    func testRemoveAtIndex() {
		print(">>> Entering testRemoveAtIndex()")
        let list = buildList()
        let prev = list.node(at: 2)
        let next = list.node(at: 3)
        let nodeCount = list.count
		print("testRemoveAtIndex(): prev → \(prev)")
		print("testRemoveAtIndex(): next → \(next)")
		print("testRemoveAtIndex(): list → \(list)")
        
        list.insert(444, at: 3)
        
        let value = list.remove(at: 3)
        XCTAssertEqual(value, 444)
        
		print("testRemoveAtIndex(): value → \(value)")
        let node = list.node(at: 3)
        XCTAssertTrue(next === node)
        XCTAssertTrue(prev.next === node)
        XCTAssertTrue(node.previous === prev)
        XCTAssertEqual(nodeCount, list.count)
		print("testRemoveAtIndex(): node → \(node)")
    }
    
    func testRemoveLastOnListWithOneElement() {
		print(">>> Entering testRemoveLastOnListWithOneElement()")
        let list = LinkedList<Int>()
        list.append(123)
        
		print("testRemoveLastOnListWithOneElement(): list → \(list)")
        let value = list.removeLast()
        XCTAssertEqual(value, 123)
        
		print("testRemoveLastOnListWithOneElement(): value → \(value)")
        XCTAssertTrue(list.isEmpty)
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
		print("<<< Exiting testRemoveLastOnListWithOneElement()")
    }
    
    func testRemoveLast() {
		print(">>> Entering testRemoveLast()")
        let list = buildList()
        let last = list.last
		print("testRemoveLast(): list → \(list)")
        let prev = last!.previous
        let nodeCount = list.count
        
        let value = list.removeLast()
        XCTAssertEqual(value, 5)
        
		print("testRemoveLast(): value → \(value)")
        XCTAssertNil(last!.previous)
        XCTAssertNil(last!.next)
        
        XCTAssertNil(prev!.next)
        XCTAssertTrue(list.last === prev)
        XCTAssertEqual(nodeCount - 1, list.count)
		print("<<< Exiting testRemoveLast()")
    }
    
    func testRemoveAll() {
		print(">>> Entering testRemoveAll()")
        let list = buildList()
        list.removeAll()
        XCTAssertTrue(list.isEmpty)
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
		print("testRemoveAll(): list → \(list)")
		print("<<< Exiting testRemoveAll()")
    }
    
    func testReverseLinkedList() {
		print(">>> Entering testReverseLinkedList()")
        let list = buildList()
        let first = list.head
		print("testReverseLinkedList(): list → \(list)")
        let last = list.last
        let nodeCount = list.count
        
        list.reverse()
        
        XCTAssertTrue(first === list.last)
        XCTAssertTrue(last === list.head)
        XCTAssertEqual(nodeCount, list.count)
		print("<<< Exiting testReverseLinkedList()")
    }
    
    func testArrayLiteralInitTypeInfer() {
		print(">>> Entering testArrayLiteralInitTypeInfer()")
        let arrayLiteralInitInfer: LinkedList = [1.0, 2.0, 3.0]
        
        XCTAssertEqual(arrayLiteralInitInfer.count, 3)
        XCTAssertEqual(arrayLiteralInitInfer.head?.value, 1.0)
        XCTAssertEqual(arrayLiteralInitInfer.last?.value, 3.0)
        XCTAssertEqual(arrayLiteralInitInfer[1], 2.0)
        XCTAssertEqual(arrayLiteralInitInfer.removeLast(), 3.0)
        XCTAssertEqual(arrayLiteralInitInfer.count, 2)
		print("<<< Exiting testArrayLiteralInitTypeInfer()")
    }
    
    func testArrayLiteralInitExplicit() {
		print(">>> Entering testArrayLiteralInitExplicit()")
        let arrayLiteralInitExplicit: LinkedList<Int> = [1, 2, 3]
        
        XCTAssertEqual(arrayLiteralInitExplicit.count, 3)
        XCTAssertEqual(arrayLiteralInitExplicit.head?.value, 1)
        XCTAssertEqual(arrayLiteralInitExplicit.last?.value, 3)
        XCTAssertEqual(arrayLiteralInitExplicit[1], 2)
        XCTAssertEqual(arrayLiteralInitExplicit.removeLast(), 3)
        XCTAssertEqual(arrayLiteralInitExplicit.count, 2)
		print("<<< Exiting testArrayLiteralInitExplicit()")
    }
    
    func testConformanceToCollectionProtocol() {
		print(">>> Entering testConformanceToCollectionProtocol()")
        let collection: LinkedList<Int> = [1, 2, 3, 4, 5]
        let index2 = collection.index(collection.startIndex, offsetBy: 2)
        let value = collection[index2]
		print("testConformanceToCollectionProtocol(): index2 → \(index2)")
        
        XCTAssertTrue(value == 3)
		print("<<< Exiting testConformanceToCollectionProtocol()")
    }
}
