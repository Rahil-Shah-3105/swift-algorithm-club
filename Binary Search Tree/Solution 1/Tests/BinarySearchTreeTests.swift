import Foundation
import XCTest

class BinarySearchTreeTest: XCTestCase {
  func testRootNode() {
	print(">>> Entering testRootNode()")
    let tree = BinarySearchTree(value: 8)
    XCTAssertEqual(tree.count, 1)
    XCTAssertEqual(tree.minimum().value, 8)
    XCTAssertEqual(tree.maximum().value, 8)
    XCTAssertEqual(tree.height(), 0)
    XCTAssertEqual(tree.depth(), 0)
    XCTAssertEqual(tree.toArray(), [8])
	print("testRootNode(): tree → \(tree)")
	print("<<< Exiting testRootNode()")
  }

  func testCreateFromArray() {
	print(">>> Entering testCreateFromArray()")
    let tree = BinarySearchTree(array: [8, 5, 10, 3, 12, 9, 6, 16])
    XCTAssertEqual(tree.count, 8)
    XCTAssertEqual(tree.toArray(), [3, 5, 6, 8, 9, 10, 12, 16])

	print("testCreateFromArray(): tree → \(tree)")
    XCTAssertEqual(tree.search(value: 9)!.value, 9)
    XCTAssertNil(tree.search(value: 99))

    XCTAssertEqual(tree.minimum().value, 3)
    XCTAssertEqual(tree.maximum().value, 16)

    XCTAssertEqual(tree.height(), 3)
    XCTAssertEqual(tree.depth(), 0)

    let node1 = tree.search(value: 16)
    XCTAssertNotNil(node1)
    XCTAssertEqual(node1!.height(), 0)
    XCTAssertEqual(node1!.depth(), 3)

	print("testCreateFromArray(): node1 → \(node1)")
    let node2 = tree.search(value: 12)
    XCTAssertNotNil(node2)
    XCTAssertEqual(node2!.height(), 1)
    XCTAssertEqual(node2!.depth(), 2)

	print("testCreateFromArray(): node2 → \(node2)")
    let node3 = tree.search(value: 10)
    XCTAssertNotNil(node3)
    XCTAssertEqual(node3!.height(), 2)
    XCTAssertEqual(node3!.depth(), 1)
	print("testCreateFromArray(): node3 → \(node3)")
	print("<<< Exiting testCreateFromArray()")
  }

  func testInsert() {
	print(">>> Entering testInsert()")
    let tree = BinarySearchTree(value: 8)

	print("testInsert(): tree → \(tree)")
    tree.insert(value: 5)
    XCTAssertEqual(tree.count, 2)
    XCTAssertEqual(tree.height(), 1)
    XCTAssertEqual(tree.depth(), 0)

    let node1 = tree.search(value: 5)
    XCTAssertNotNil(node1)
    XCTAssertEqual(node1!.height(), 0)
    XCTAssertEqual(node1!.depth(), 1)

	print("testInsert(): node1 → \(node1)")
    tree.insert(value: 10)
    XCTAssertEqual(tree.count, 3)
    XCTAssertEqual(tree.height(), 1)
    XCTAssertEqual(tree.depth(), 0)

    let node2 = tree.search(value: 10)
    XCTAssertNotNil(node2)
    XCTAssertEqual(node2!.height(), 0)
    XCTAssertEqual(node2!.depth(), 1)

	print("testInsert(): node2 → \(node2)")
    tree.insert(value: 3)
    XCTAssertEqual(tree.count, 4)
    XCTAssertEqual(tree.height(), 2)
    XCTAssertEqual(tree.depth(), 0)

    let node3 = tree.search(value: 3)
    XCTAssertNotNil(node3)
    XCTAssertEqual(node3!.height(), 0)
    XCTAssertEqual(node3!.depth(), 2)
    XCTAssertEqual(node1!.height(), 1)
    XCTAssertEqual(node1!.depth(), 1)

	print("testInsert(): node3 → \(node3)")
    XCTAssertEqual(tree.minimum().value, 3)
    XCTAssertEqual(tree.maximum().value, 10)
    XCTAssertEqual(tree.toArray(), [3, 5, 8, 10])
	print("<<< Exiting testInsert()")
  }

  func testInsertDuplicates() {
	print(">>> Entering testInsertDuplicates()")
    let tree = BinarySearchTree(array: [8, 5, 10])
    tree.insert(value: 8)
    tree.insert(value: 5)
    tree.insert(value: 10)
    XCTAssertEqual(tree.count, 6)
    XCTAssertEqual(tree.toArray(), [5, 5, 8, 8, 10, 10])
	print("testInsertDuplicates(): tree → \(tree)")
	print("<<< Exiting testInsertDuplicates()")
  }

  func testTraversing() {
	print(">>> Entering testTraversing()")
    let tree = BinarySearchTree(array: [8, 5, 10, 3, 12, 9, 6, 16])

	print("testTraversing(): tree → \(tree)")
	print("testTraversing(): inOrder → \(inOrder)")
    var inOrder = [Int]()
    tree.traverseInOrder { inOrder.append($0) }
    XCTAssertEqual(inOrder, [3, 5, 6, 8, 9, 10, 12, 16])

    var preOrder = [Int]()
    tree.traversePreOrder { preOrder.append($0) }
	print("testTraversing(): preOrder → \(preOrder)")
    XCTAssertEqual(preOrder, [8, 5, 3, 6, 10, 9, 12, 16])

    var postOrder = [Int]()
    tree.traversePostOrder { postOrder.append($0) }
	print("testTraversing(): postOrder → \(postOrder)")
    XCTAssertEqual(postOrder, [3, 6, 5, 9, 16, 12, 10, 8])
	print("<<< Exiting testTraversing()")
  }

  func testInsertSorted() {
	print(">>> Entering testInsertSorted()")
    let tree = BinarySearchTree(array: [8, 5, 10, 3, 12, 9, 6, 16].sorted(by: <))
    XCTAssertEqual(tree.count, 8)
    XCTAssertEqual(tree.toArray(), [3, 5, 6, 8, 9, 10, 12, 16])

	print("testInsertSorted(): tree → \(tree)")
    XCTAssertEqual(tree.minimum().value, 3)
    XCTAssertEqual(tree.maximum().value, 16)

    XCTAssertEqual(tree.height(), 7)
    XCTAssertEqual(tree.depth(), 0)

    let node1 = tree.search(value: 16)
    XCTAssertNotNil(node1)
    XCTAssertEqual(node1!.height(), 0)
    XCTAssertEqual(node1!.depth(), 7)
	print("testInsertSorted(): node1 → \(node1)")
	print("<<< Exiting testInsertSorted()")
  }

  func testRemoveLeaf() {
	print(">>> Entering testRemoveLeaf()")
    let tree = BinarySearchTree(array: [8, 5, 10, 4])

	print("testRemoveLeaf(): tree → \(tree)")
	print("testRemoveLeaf(): node10 → \(node10)")
    let node10 = tree.search(value: 10)!
    XCTAssertNil(node10.left)
    XCTAssertNil(node10.right)
    XCTAssertTrue(tree.right === node10)

    let node5 = tree.search(value: 5)!
	print("testRemoveLeaf(): node5 → \(node5)")
    XCTAssertTrue(tree.left === node5)

    let node4 = tree.search(value: 4)!
	print("testRemoveLeaf(): node4 → \(node4)")
    XCTAssertTrue(node5.left === node4)
    XCTAssertNil(node5.right)

    let replacement1 = node4.remove()
    XCTAssertNil(node5.left)
    XCTAssertNil(replacement1)

	print("testRemoveLeaf(): replacement1 → \(replacement1)")
    let replacement2 = node5.remove()
    XCTAssertNil(tree.left)
    XCTAssertNil(replacement2)

	print("testRemoveLeaf(): replacement2 → \(replacement2)")
    let replacement3 = node10.remove()
    XCTAssertNil(tree.right)
    XCTAssertNil(replacement3)

	print("testRemoveLeaf(): replacement3 → \(replacement3)")
    XCTAssertEqual(tree.count, 1)
    XCTAssertEqual(tree.toArray(), [8])
	print("<<< Exiting testRemoveLeaf()")
  }

  func testRemoveOneChildLeft() {
	print(">>> Entering testRemoveOneChildLeft()")
    let tree = BinarySearchTree(array: [8, 5, 10, 4, 9])

	print("testRemoveOneChildLeft(): tree → \(tree)")
	print("testRemoveOneChildLeft(): node4 → \(node4)")
	print("testRemoveOneChildLeft(): node5 → \(node5)")
    let node4 = tree.search(value: 4)!
    let node5 = tree.search(value: 5)!
    XCTAssertTrue(node5.left === node4)
    XCTAssertTrue(node5 === node4.parent)

    node5.remove()
    XCTAssertTrue(tree.left === node4)
    XCTAssertTrue(tree === node4.parent)
    XCTAssertNil(node4.left)
    XCTAssertNil(node4.right)
    XCTAssertEqual(tree.count, 4)
    XCTAssertEqual(tree.toArray(), [4, 8, 9, 10])

    let node9 = tree.search(value: 9)!
	print("testRemoveOneChildLeft(): node9 → \(node9)")
	print("testRemoveOneChildLeft(): node10 → \(node10)")
    let node10 = tree.search(value: 10)!
    XCTAssertTrue(node10.left === node9)
    XCTAssertTrue(node10 === node9.parent)

    node10.remove()
    XCTAssertTrue(tree.right === node9)
    XCTAssertTrue(tree === node9.parent)
    XCTAssertNil(node9.left)
    XCTAssertNil(node9.right)
    XCTAssertEqual(tree.count, 3)
    XCTAssertEqual(tree.toArray(), [4, 8, 9])
	print("<<< Exiting testRemoveOneChildLeft()")
  }

  func testRemoveOneChildRight() {
	print(">>> Entering testRemoveOneChildRight()")
    let tree = BinarySearchTree(array: [8, 5, 10, 6, 11])

	print("testRemoveOneChildRight(): tree → \(tree)")
	print("testRemoveOneChildRight(): node6 → \(node6)")
	print("testRemoveOneChildRight(): node5 → \(node5)")
    let node6 = tree.search(value: 6)!
    let node5 = tree.search(value: 5)!
    XCTAssertTrue(node5.right === node6)
    XCTAssertTrue(node5 === node6.parent)

    node5.remove()
    XCTAssertTrue(tree.left === node6)
    XCTAssertTrue(tree === node6.parent)
    XCTAssertNil(node6.left)
    XCTAssertNil(node6.right)
    XCTAssertEqual(tree.count, 4)
    XCTAssertEqual(tree.toArray(), [6, 8, 10, 11])

    let node11 = tree.search(value: 11)!
	print("testRemoveOneChildRight(): node11 → \(node11)")
	print("testRemoveOneChildRight(): node10 → \(node10)")
    let node10 = tree.search(value: 10)!
    XCTAssertTrue(node10.right === node11)
    XCTAssertTrue(node10 === node11.parent)

    node10.remove()
    XCTAssertTrue(tree.right === node11)
    XCTAssertTrue(tree === node11.parent)
    XCTAssertNil(node11.left)
    XCTAssertNil(node11.right)
    XCTAssertEqual(tree.count, 3)
    XCTAssertEqual(tree.toArray(), [6, 8, 11])
	print("<<< Exiting testRemoveOneChildRight()")
  }

  func testRemoveTwoChildrenSimple() {
	print(">>> Entering testRemoveTwoChildrenSimple()")
    let tree = BinarySearchTree(array: [8, 5, 10, 4, 6, 9, 11])

	print("testRemoveTwoChildrenSimple(): tree → \(tree)")
	print("testRemoveTwoChildrenSimple(): node4 → \(node4)")
	print("testRemoveTwoChildrenSimple(): node5 → \(node5)")
	print("testRemoveTwoChildrenSimple(): node6 → \(node6)")
    let node4 = tree.search(value: 4)!
    let node5 = tree.search(value: 5)!
    let node6 = tree.search(value: 6)!
    XCTAssertTrue(node5.left === node4)
    XCTAssertTrue(node5.right === node6)
    XCTAssertTrue(node5 === node4.parent)
    XCTAssertTrue(node5 === node6.parent)

    let replacement1 = node5.remove()
    XCTAssertTrue(replacement1 === node6)
    XCTAssertTrue(tree.left === node6)
    XCTAssertTrue(tree === node6.parent)
    XCTAssertTrue(node6.left === node4)
    XCTAssertTrue(node6 === node4.parent)
    XCTAssertNil(node5.left)
    XCTAssertNil(node5.right)
    XCTAssertNil(node5.parent)
    XCTAssertNil(node4.left)
    XCTAssertNil(node4.right)
    XCTAssertNotNil(node4.parent)
    XCTAssertEqual(tree.count, 6)
    XCTAssertEqual(tree.toArray(), [4, 6, 8, 9, 10, 11])

	print("testRemoveTwoChildrenSimple(): replacement1 → \(replacement1)")
    let node9 = tree.search(value: 9)!
	print("testRemoveTwoChildrenSimple(): node9 → \(node9)")
	print("testRemoveTwoChildrenSimple(): node10 → \(node10)")
	print("testRemoveTwoChildrenSimple(): node11 → \(node11)")
    let node10 = tree.search(value: 10)!
    let node11 = tree.search(value: 11)!
    XCTAssertTrue(node10.left === node9)
    XCTAssertTrue(node10.right === node11)
    XCTAssertTrue(node10 === node9.parent)
    XCTAssertTrue(node10 === node11.parent)

    let replacement2 = node10.remove()
    XCTAssertTrue(replacement2 === node11)
    XCTAssertTrue(tree.right === node11)
    XCTAssertTrue(tree === node11.parent)
    XCTAssertTrue(node11.left === node9)
    XCTAssertTrue(node11 === node9.parent)
    XCTAssertNil(node10.left)
    XCTAssertNil(node10.right)
    XCTAssertNil(node10.parent)
    XCTAssertNil(node9.left)
    XCTAssertNil(node9.right)
    XCTAssertNotNil(node9.parent)
    XCTAssertEqual(tree.count, 5)
    XCTAssertEqual(tree.toArray(), [4, 6, 8, 9, 11])
	print("testRemoveTwoChildrenSimple(): replacement2 → \(replacement2)")
	print("<<< Exiting testRemoveTwoChildrenSimple()")
  }

  func testRemoveTwoChildrenComplex() {
	print(">>> Entering testRemoveTwoChildrenComplex()")
    let tree = BinarySearchTree(array: [8, 5, 10, 4, 9, 20, 11, 15, 13])

	print("testRemoveTwoChildrenComplex(): tree → \(tree)")
	print("testRemoveTwoChildrenComplex(): node9 → \(node9)")
	print("testRemoveTwoChildrenComplex(): node10 → \(node10)")
	print("testRemoveTwoChildrenComplex(): node11 → \(node11)")
	print("testRemoveTwoChildrenComplex(): node13 → \(node13)")
	print("testRemoveTwoChildrenComplex(): node15 → \(node15)")
	print("testRemoveTwoChildrenComplex(): node20 → \(node20)")
    let node9 = tree.search(value: 9)!
    let node10 = tree.search(value: 10)!
    let node11 = tree.search(value: 11)!
    let node13 = tree.search(value: 13)!
    let node15 = tree.search(value: 15)!
    let node20 = tree.search(value: 20)!
    XCTAssertTrue(node10.left === node9)
    XCTAssertTrue(node10 === node9.parent)
    XCTAssertTrue(node10.right === node20)
    XCTAssertTrue(node10 === node20.parent)
    XCTAssertTrue(node20.left === node11)
    XCTAssertTrue(node20 === node11.parent)
    XCTAssertTrue(node11.right === node15)
    XCTAssertTrue(node11 === node15.parent)

    let replacement = node10.remove()
    XCTAssertTrue(replacement === node11)
    XCTAssertTrue(tree.right === node11)
    XCTAssertTrue(tree === node11.parent)
    XCTAssertTrue(node11.left === node9)
    XCTAssertTrue(node11 === node9.parent)
    XCTAssertTrue(node11.right === node20)
    XCTAssertTrue(node11 === node20.parent)
    XCTAssertTrue(node20.left === node13)
    XCTAssertTrue(node20 === node13.parent)
    XCTAssertNil(node20.right)
    XCTAssertNil(node10.left)
    XCTAssertNil(node10.right)
    XCTAssertNil(node10.parent)
    XCTAssertEqual(tree.count, 8)
    XCTAssertEqual(tree.toArray(), [4, 5, 8, 9, 11, 13, 15, 20])
	print("testRemoveTwoChildrenComplex(): replacement → \(replacement)")
	print("<<< Exiting testRemoveTwoChildrenComplex()")
  }

  func testRemoveRoot() {
	print(">>> Entering testRemoveRoot()")
    let tree = BinarySearchTree(array: [8, 5, 10, 4, 9, 20, 11, 15, 13])

	print("testRemoveRoot(): tree → \(tree)")
	print("testRemoveRoot(): node9 → \(node9)")
    let node9 = tree.search(value: 9)!

    let newRoot = tree.remove()
    XCTAssertTrue(newRoot === node9)
    XCTAssertEqual(newRoot!.value, 9)
    XCTAssertEqual(newRoot!.count, 8)
    XCTAssertEqual(newRoot!.toArray(), [4, 5, 9, 10, 11, 13, 15, 20])

	print("testRemoveRoot(): newRoot → \(newRoot)")
    // The old root is a subtree of a single element.
    XCTAssertEqual(tree.value, 8)
    XCTAssertEqual(tree.count, 1)
    XCTAssertEqual(tree.toArray(), [8])
	print("<<< Exiting testRemoveRoot()")
  }

  func testPredecessor() {
	print(">>> Entering testPredecessor()")
    let tree = BinarySearchTree(array: [3, 1, 2, 5, 4])
    let node = tree.search(value: 5)

	print("testPredecessor(): node → \(node)")
	print("testPredecessor(): tree → \(tree)")
    XCTAssertEqual(node!.value, 5)
    XCTAssertEqual(node!.predecessor()!.value, 4)
    XCTAssertEqual(node!.predecessor()!.predecessor()!.value, 3)
    XCTAssertEqual(node!.predecessor()!.predecessor()!.predecessor()!.value, 2)
    XCTAssertEqual(node!.predecessor()!.predecessor()!.predecessor()!.predecessor()!.value, 1)
    XCTAssertNil(node!.predecessor()!.predecessor()!.predecessor()!.predecessor()!.predecessor())
	print("<<< Exiting testPredecessor()")
  }

  func testSuccessor() {
	print(">>> Entering testSuccessor()")
    let tree = BinarySearchTree(array: [3, 1, 2, 5, 4])
    let node = tree.search(value: 1)

	print("testSuccessor(): node → \(node)")
	print("testSuccessor(): tree → \(tree)")
    XCTAssertEqual(node!.value, 1)
    XCTAssertEqual(node!.successor()!.value, 2)
    XCTAssertEqual(node!.successor()!.successor()!.value, 3)
    XCTAssertEqual(node!.successor()!.successor()!.successor()!.value, 4)
    XCTAssertEqual(node!.successor()!.successor()!.successor()!.successor()!.value, 5)
    XCTAssertNil(node!.successor()!.successor()!.successor()!.successor()!.successor())
	print("<<< Exiting testSuccessor()")
  }
}
