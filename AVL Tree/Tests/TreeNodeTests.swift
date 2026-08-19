//
//  TreeNodeTest.swift
//  AVLTreeTests
//
//  Created by Barbara Rodeker on 2/19/16.
//  Copyright © 2016 Swift Algorithm Club. All rights reserved.
//

import XCTest

class TreeNodeTests: XCTestCase {
   
    var root: TreeNode<String, String>?
    var left: TreeNode<String, String>?
    var right: TreeNode<String, String>?
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

        left = TreeNode<String, String>(key: "Name", payload: "Left")
        right = TreeNode<String, String>(key: "Name", payload: "Right")
        root = TreeNode<String, String>(key: "Name", payload: "Root", leftChild: left, rightChild: right, parent: nil, height: 0)
		print("setUp(): left → \(left)")
		print("setUp(): right → \(right)")
		print("setUp(): root → \(root)")
		print("<<< Exiting setUp()")
    }

    override func tearDown() {
		print(">>> Entering tearDown()")
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		print("<<< Exiting tearDown()")
    }

    func testSingleNodeCreationNOPayload() {
		print(">>> Entering testSingleNodeCreationNOPayload()")
        let treeNode = TreeNode<String, String>(key: "Building")
        XCTAssertNil(treeNode.payload, "Payload for this case should be nil")
		print("testSingleNodeCreationNOPayload(): treeNode → \(treeNode)")
		print("<<< Exiting testSingleNodeCreationNOPayload()")
    }

    func testSingleNodeCreationWithPayload() {
		print(">>> Entering testSingleNodeCreationWithPayload()")
        XCTAssertNotNil(self.root!, "Payload for this case should not be nil")
		print("<<< Exiting testSingleNodeCreationWithPayload()")
    }

    func testIsRoot() {
		print(">>> Entering testIsRoot()")
        XCTAssertTrue(self.root!.isRoot)
		print("<<< Exiting testIsRoot()")
    }

    func testNotIsLeaf() {
		print(">>> Entering testNotIsLeaf()")
        XCTAssertFalse(self.root!.isLeaf, "root node is not leaf")
		print("<<< Exiting testNotIsLeaf()")
    }

    func testNotIsLeftChild() {
		print(">>> Entering testNotIsLeftChild()")
        XCTAssertFalse(self.root!.isLeftChild, "root node is not left child")
		print("<<< Exiting testNotIsLeftChild()")
    }

    func testNotIsRightChild() {
		print(">>> Entering testNotIsRightChild()")
        XCTAssertFalse(self.root!.isRightChild, "root node is not right child")
		print("<<< Exiting testNotIsRightChild()")
    }

    func testIsLeftChild() {
		print(">>> Entering testIsLeftChild()")
        XCTAssertTrue(self.left!.isLeftChild)
		print("<<< Exiting testIsLeftChild()")
    }

    func testIsRightChild() {
		print(">>> Entering testIsRightChild()")
        XCTAssertTrue(self.right!.isRightChild)
		print("<<< Exiting testIsRightChild()")
    }

    func isLeaf() {
		print(">>> Entering isLeaf()")
        XCTAssertTrue(self.left!.isLeaf)
		print("<<< Exiting isLeaf()")
    }

    func testHasAnyChild() {
		print(">>> Entering testHasAnyChild()")
        XCTAssertTrue(self.root!.hasAnyChild)
		print("<<< Exiting testHasAnyChild()")
    }

    func testNotHasAnyChild() {
		print(">>> Entering testNotHasAnyChild()")
        XCTAssertFalse(self.left!.hasAnyChild)
		print("<<< Exiting testNotHasAnyChild()")
    }

    func testHasBothChildren() {
		print(">>> Entering testHasBothChildren()")
        XCTAssertTrue(self.root!.hasBothChildren)
		print("<<< Exiting testHasBothChildren()")
    }

    func testNotHasBothChildren() {
		print(">>> Entering testNotHasBothChildren()")
        XCTAssertFalse(self.left!.hasBothChildren)
		print("<<< Exiting testNotHasBothChildren()")
    }

}
