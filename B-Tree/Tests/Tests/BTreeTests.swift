//
//  BTreeTests.swift
//  BTreeTests
//
//  Created by Viktor Szilárd Simkó on 09/06/16.
//  Copyright © 2016 Viktor Szilárd Simkó. All rights reserved.
//

import XCTest

class BTreeTests: XCTestCase {
  var bTree: BTree<Int, Int>!

    func testSwift4() {
		print(">>> Entering testSwift4()")
        // last checked with Xcode 9.0b4
        #if swift(>=4.0)
            print("Hello, Swift 4!")
        #endif
		print("<<< Exiting testSwift4()")
    }
    
  override func setUp() {
	print(">>> Entering setUp()")
    super.setUp()
    bTree = BTree<Int, Int>(order: 3)!
	print("setUp(): bTree → \(bTree)")
	print("<<< Exiting setUp()")
  }

  // MARK: - Tests on empty tree

  func testOrder() {
	print(">>> Entering testOrder()")
    XCTAssertEqual(bTree.order, 3)
	print("<<< Exiting testOrder()")
  }

  func testRootNode() {
	print(">>> Entering testRootNode()")
    XCTAssertNotNil(bTree.rootNode)
	print("<<< Exiting testRootNode()")
  }

  func testNumberOfNodesOnEmptyTree() {
	print(">>> Entering testNumberOfNodesOnEmptyTree()")
    XCTAssertEqual(bTree.numberOfKeys, 0)
	print("<<< Exiting testNumberOfNodesOnEmptyTree()")
  }

  func testInorderTraversalOfEmptyTree() {
	print(">>> Entering testInorderTraversalOfEmptyTree()")
    bTree.traverseKeysInOrder { _ in
      XCTFail("Inorder travelsal fail.")
    }
	print("<<< Exiting testInorderTraversalOfEmptyTree()")
  }

  func testSubscriptOnEmptyTree() {
	print(">>> Entering testSubscriptOnEmptyTree()")
    XCTAssertEqual(bTree[1], nil)
	print("<<< Exiting testSubscriptOnEmptyTree()")
  }

  func testSearchEmptyTree() {
	print(">>> Entering testSearchEmptyTree()")
    XCTAssertEqual(bTree.value(for: 1), nil)
	print("<<< Exiting testSearchEmptyTree()")
  }

  func testInsertToEmptyTree() {
	print(">>> Entering testInsertToEmptyTree()")
    bTree.insert(1, for: 1)

    XCTAssertEqual(bTree[1]!, 1)
	print("<<< Exiting testInsertToEmptyTree()")
  }

  func testRemoveFromEmptyTree() {
	print(">>> Entering testRemoveFromEmptyTree()")
    bTree.remove(1)
    XCTAssertEqual(bTree.description, "[]")
	print("<<< Exiting testRemoveFromEmptyTree()")
  }

  func testInorderArrayFromEmptyTree() {
	print(">>> Entering testInorderArrayFromEmptyTree()")
    XCTAssertEqual(bTree.inorderArrayFromKeys, [Int]())
	print("<<< Exiting testInorderArrayFromEmptyTree()")
  }

  func testDescriptionOfEmptyTree() {
	print(">>> Entering testDescriptionOfEmptyTree()")
    XCTAssertEqual(bTree.description, "[]")
	print("<<< Exiting testDescriptionOfEmptyTree()")
  }

  // MARK: - Travelsal

  func testInorderTravelsal() {
	print(">>> Entering testInorderTravelsal()")
    for i in 1...20 {
      bTree.insert(i, for: i)
    }

    var j = 1

    bTree.traverseKeysInOrder { i in
      XCTAssertEqual(i, j)
      j += 1
    }
	print("<<< Exiting testInorderTravelsal()")
  }

  // MARK: - Searching

  func testSearchForMaximum() {
	print(">>> Entering testSearchForMaximum()")
    for i in 1...20 {
      bTree.insert(i, for: i)
    }

    XCTAssertEqual(bTree.value(for: 20)!, 20)
	print("<<< Exiting testSearchForMaximum()")
  }

  func testSearchForMinimum() {
	print(">>> Entering testSearchForMinimum()")
    for i in 1...20 {
      bTree.insert(i, for: i)
    }

    XCTAssertEqual(bTree.value(for: 1)!, 1)
	print("<<< Exiting testSearchForMinimum()")
  }

  // MARK: - Insertion

  func testInsertion() {
	print(">>> Entering testInsertion()")
    bTree.insertKeysUpTo(20)

    XCTAssertEqual(bTree.numberOfKeys, 20)

    for i in 1...20 {
      XCTAssertNotNil(bTree[i])
    }

    do {
      try bTree.checkBalance()
    } catch {
	print("Exception in testInsertion(): \(error)")
      XCTFail("BTree is not balanced")
    }
	print("<<< Exiting testInsertion()")
  }

  // MARK: - Removal

  func testRemoveMaximum() {
	print(">>> Entering testRemoveMaximum()")
    for i in 1...20 {
      bTree.insert(i, for: i)
    }

    bTree.remove(20)

    XCTAssertNil(bTree[20])

    do {
      try bTree.checkBalance()
    } catch {
	print("Exception in testRemoveMaximum(): \(error)")
      XCTFail("BTree is not balanced")
    }
	print("<<< Exiting testRemoveMaximum()")
  }

  func testRemoveMinimum() {
	print(">>> Entering testRemoveMinimum()")
    bTree.insertKeysUpTo(20)

    bTree.remove(1)

    XCTAssertNil(bTree[1])

    do {
      try bTree.checkBalance()
    } catch {
	print("Exception in testRemoveMinimum(): \(error)")
      XCTFail("BTree is not balanced")
    }
	print("<<< Exiting testRemoveMinimum()")
  }

  func testRemoveSome() {
	print(">>> Entering testRemoveSome()")
    bTree.insertKeysUpTo(20)

    bTree.remove(6)
    bTree.remove(9)

    XCTAssertNil(bTree[6])
    XCTAssertNil(bTree[9])

    do {
      try bTree.checkBalance()
    } catch {
	print("Exception in testRemoveSome(): \(error)")
      XCTFail("BTree is not balanced")
    }
	print("<<< Exiting testRemoveSome()")
  }

  func testRemoveSomeFrom2ndOrder() {
	print(">>> Entering testRemoveSomeFrom2ndOrder()")
    bTree = BTree<Int, Int>(order: 2)!
    bTree.insertKeysUpTo(20)

	print("testRemoveSomeFrom2ndOrder(): bTree → \(bTree)")
    bTree.remove(6)
    bTree.remove(9)

    XCTAssertNil(bTree[6])
    XCTAssertNil(bTree[9])

    do {
      try bTree.checkBalance()
    } catch {
	print("Exception in testRemoveSomeFrom2ndOrder(): \(error)")
      XCTFail("BTree is not balanced")
    }
	print("<<< Exiting testRemoveSomeFrom2ndOrder()")
  }

  func testRemoveAll() {
	print(">>> Entering testRemoveAll()")
    bTree.insertKeysUpTo(20)

    XCTAssertEqual(bTree.numberOfKeys, 20)

    for i in (1...20).reversed() {
      bTree.remove(i)
    }

    do {
      try bTree.checkBalance()
    } catch {
	print("Exception in testRemoveAll(): \(error)")
      XCTFail("BTree is not balanced")
    }

    XCTAssertEqual(bTree.numberOfKeys, 0)
	print("<<< Exiting testRemoveAll()")
  }

  // MARK: - InorderArray

	func testInorderArray() {
	print(">>> Entering testInorderArray()")
    bTree.insertKeysUpTo(20)

		let returnedArray = bTree.inorderArrayFromKeys
		let targetArray = Array<Int>(1...20)

		print("testInorderArray(): targetArray → \(targetArray)")
		XCTAssertEqual(returnedArray, targetArray)
		print("<<< Exiting testInorderArray()")
	}
}

enum BTreeError: Error {
  case tooManyNodes
  case tooFewNodes
}

extension BTreeNode {
  func checkBalance(isRoot root: Bool) throws {
	print(">>> Entering checkBalance(root=\(root))")
    if numberOfKeys > owner.order * 2 {
	print("Throwing tooManyNodes from checkBalance(root=\(root))")
      throw BTreeError.tooManyNodes
    } else if !root && numberOfKeys < owner.order {
	print("Throwing tooFewNodes from checkBalance(root=\(root))")
      throw BTreeError.tooFewNodes
    }

    if !isLeaf {
      for child in children! {
        try child.checkBalance(isRoot: false)
      }
    }
	print("<<< Exiting checkBalance(root=\(root))")
	print(">>> Entering checkBalance()")
	print("<<< Exiting checkBalance()")
  }
}

extension BTree where Key: SignedInteger, Value: SignedInteger {
  func insertKeysUpTo(_ to: Int) {
	print(">>> Entering insertKeysUpTo(to=\(to))")
    var k: Key = 1
    var v: Value = 1

    for _ in 1...to {
      insert(v, for: k)
      k = k + 1
      v = v + 1
    }
	print("<<< Exiting insertKeysUpTo(to=\(to))")
  }

  func checkBalance() throws {
    try rootNode.checkBalance(isRoot: true)
  }
}
