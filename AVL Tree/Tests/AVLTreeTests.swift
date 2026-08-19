//
//  AVLTreeTestsTests.swift
//  AVLTreeTestsTests
//
//  Created by Barbara Rodeker on 2/19/16.
//  Copyright © 2016 Swift Algorithm Club. All rights reserved.
//

import XCTest
class AVLTreeTests: XCTestCase {
  var tree: AVLTree<Int, String>?

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

    tree = AVLTree()
	print("setUp(): tree → \(tree)")
	print("<<< Exiting setUp()")
  }

  override func tearDown() {
	print(">>> Entering tearDown()")
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
	print("<<< Exiting tearDown()")
  }

  func testAVLTreeBalancedAutoPopulate() {
	print(">>> Entering testAVLTreeBalancedAutoPopulate()")
    self.tree?.autopopulateWithNodes(10)

    do {
      try self.tree?.inOrderCheckBalanced(self.tree?.root)
    } catch _ {
	print("Exception in testAVLTreeBalancedAutoPopulate(): \(error)")
      XCTFail("Tree is not balanced after autopopulate")
    }
	print("<<< Exiting testAVLTreeBalancedAutoPopulate()")
  }

  func testAVLTreeBalancedInsert() {
	print(">>> Entering testAVLTreeBalancedInsert()")
    self.tree?.autopopulateWithNodes(5)

    for i in 6...10 {
      self.tree?.insert(key: i)
      do {
        try self.tree?.inOrderCheckBalanced(self.tree?.root)
      } catch _ {
		print("Exception in testAVLTreeBalancedInsert(): \(error)")
        XCTFail("Tree is not balanced after inserting " + String(i))
      }
    }
	print("<<< Exiting testAVLTreeBalancedInsert()")
  }

  func testAVLTreeBalancedDelete() {
	print(">>> Entering testAVLTreeBalancedDelete()")
    self.tree?.autopopulateWithNodes(5)

    for i in 1...6 {
      self.tree?.delete(key: i)
      do {
        try self.tree?.inOrderCheckBalanced(self.tree?.root)
      } catch _ {
		print("Exception in testAVLTreeBalancedDelete(): \(error)")
        XCTFail("Tree is not balanced after deleting " + String(i))
      }
    }
	print("<<< Exiting testAVLTreeBalancedDelete()")
  }

  func testEmptyInitialization() {
	print(">>> Entering testEmptyInitialization()")
    let tree = AVLTree<Int, String>()

	print("testEmptyInitialization(): tree → \(tree)")
    XCTAssertEqual(tree.size, 0)
    XCTAssertNil(tree.root)
	print("<<< Exiting testEmptyInitialization()")
  }

  func testSingleInsertionPerformance() {
	print(">>> Entering testSingleInsertionPerformance()")
    self.measure {
      self.tree?.insert(key: 5, payload: "E")
    }
	print("<<< Exiting testSingleInsertionPerformance()")
  }

  func testMultipleInsertionsPerformance() {
	print(">>> Entering testMultipleInsertionsPerformance()")
    self.measure {
      self.tree?.autopopulateWithNodes(50)
    }
	print("<<< Exiting testMultipleInsertionsPerformance()")
  }

  func testSearchExistentOnSmallTreePerformance() {
	print(">>> Entering testSearchExistentOnSmallTreePerformance()")
    self.measure {
      print(self.tree?.search(input: 2))
    }
	print("<<< Exiting testSearchExistentOnSmallTreePerformance()")
  }

  func testSearchExistentElementOnLargeTreePerformance() {
	print(">>> Entering testSearchExistentElementOnLargeTreePerformance()")
    self.measure {
      self.tree?.autopopulateWithNodes(500)
      print(self.tree?.search(input: 400))
    }
	print("<<< Exiting testSearchExistentElementOnLargeTreePerformance()")
  }

  func testMinimumOnPopulatedTree() {
	print(">>> Entering testMinimumOnPopulatedTree()")
    self.tree?.autopopulateWithNodes(500)
    let min = self.tree?.root?.minimum()
    XCTAssertNotNil(min, "Minimum function not working")
	print("testMinimumOnPopulatedTree(): min → \(min)")
	print("<<< Exiting testMinimumOnPopulatedTree()")
  }

  func testMinimumOnSingleTreeNode() {
	print(">>> Entering testMinimumOnSingleTreeNode()")
    let treeNode = TreeNode(key: 1, payload: "A")
    let min = treeNode.minimum()

	print("testMinimumOnSingleTreeNode(): min → \(min)")
	print("testMinimumOnSingleTreeNode(): treeNode → \(treeNode)")
    XCTAssertNotNil(min, "Minimum on single node should be returned")
    XCTAssertEqual(min?.payload, treeNode.payload)
	print("<<< Exiting testMinimumOnSingleTreeNode()")
  }

  func testDeleteExistentKey() {
	print(">>> Entering testDeleteExistentKey()")
    self.tree?.delete(key: 1)
    XCTAssertNil(self.tree?.search(input: 1), "Key should not exist anymore")
	print("<<< Exiting testDeleteExistentKey()")
  }

  func testDeleteNotExistentKey() {
	print(">>> Entering testDeleteNotExistentKey()")
    self.tree?.delete(key: 1056)
    XCTAssertNil(self.tree?.search(input: 1056), "Key should not exist")
	print("<<< Exiting testDeleteNotExistentKey()")
  }

  func testInsertSize() {
	print(">>> Entering testInsertSize()")
    let tree = AVLTree<Int, String>()
    for i in 0...5 {
	print("testInsertSize(): tree → \(tree)")
      tree.insert(key: i, payload: "")
      XCTAssertEqual(tree.size, i + 1, "Insert didn't update size correctly!")
    }
	print("<<< Exiting testInsertSize()")
  }

  func testDelete() {
	print(">>> Entering testDelete()")
    let permutations = [
      [5, 1, 4, 2, 3],
      [2, 3, 1, 5, 4],
      [4, 5, 3, 2, 1],
      [3, 2, 5, 4, 1],
    ]

    for p in permutations {
      let tree = AVLTree<Int, String>()

	print("testDelete(): tree → \(tree)")
      tree.insert(key: 1, payload: "five")
      tree.insert(key: 2, payload: "four")
      tree.insert(key: 3, payload: "three")
      tree.insert(key: 4, payload: "two")
      tree.insert(key: 5, payload: "one")

      var count = tree.size
	print("testDelete(): count → \(count)")
      for i in p {
        tree.delete(key: i)
        count -= 1
        XCTAssertEqual(tree.size, count, "Delete didn't update size correctly!")
      }
    }
	print("<<< Exiting testDelete()")
  }
}

extension AVLTree where Key : SignedInteger {
  func autopopulateWithNodes(_ count: Int) {
	print(">>> Entering autopopulateWithNodes(count=\(count))")
    var k: Key = 1
    for _ in 0...count {
      self.insert(key: k)
      k = k + 1
    }
	print("<<< Exiting autopopulateWithNodes(count=\(count))")
  }
}

enum AVLTreeError: Error {
  case notBalanced
}

extension AVLTree where Key : SignedInteger {
  func height(_ node: Node?) -> Int {
	print(">>> Entering height(node=\(node))")
    if let node = node {
      let lHeight = height(node.leftChild)
      let rHeight = height(node.rightChild)

	print("height(node=\(node)): lHeight → \(lHeight)")
	print("height(node=\(node)): rHeight → \(rHeight)")
	print("<<< Exiting height(node=\(node))")
      return max(lHeight, rHeight) + 1
    }
    return 0
  }

  func inOrderCheckBalanced(_ node: Node?) throws {
	print(">>> Entering inOrderCheckBalanced(node=\(node))")
    if let node = node {
      guard abs(height(node.leftChild) - height(node.rightChild)) <= 1 else {
		print("Throwing notBalanced from inOrderCheckBalanced(node=\(node))")
        throw AVLTreeError.notBalanced
      }
      try inOrderCheckBalanced(node.leftChild)
      try inOrderCheckBalanced(node.rightChild)
    }
	print("<<< Exiting inOrderCheckBalanced(node=\(node))")
  }
}
