//
//  BTreeNodeTests.swift
//  BTree
//
//  Created by Viktor Szilárd Simkó on 13/06/16.
//  Copyright © 2016 Viktor Szilárd Simkó. All rights reserved.
//

import XCTest

class BTreeNodeTests: XCTestCase {
    
    let owner = BTree<Int, Int>(order: 2)!
    var root: BTreeNode<Int, Int>!
    var leftChild: BTreeNode<Int, Int>!
    var rightChild: BTreeNode<Int, Int>!
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
        
        root = BTreeNode(owner: owner)
        leftChild = BTreeNode(owner: owner)
        rightChild = BTreeNode(owner: owner)
        
		print("setUp(): root → \(root)")
		print("setUp(): leftChild → \(leftChild)")
		print("setUp(): rightChild → \(rightChild)")
        root.insert(1, for: 1)
        root.children = [leftChild, rightChild]
		print("setUp(): root.children → \(root.children)")
		print("<<< Exiting setUp()")
    }
    
    func testIsLeafRoot() {
		print(">>> Entering testIsLeafRoot()")
        XCTAssertFalse(root.isLeaf)
		print("<<< Exiting testIsLeafRoot()")
    }
    
    func testIsLeafLeaf() {
		print(">>> Entering testIsLeafLeaf()")
        XCTAssertTrue(leftChild.isLeaf)
        XCTAssertTrue(rightChild.isLeaf)
		print("<<< Exiting testIsLeafLeaf()")
    }
    
    func testOwner() {
		print(">>> Entering testOwner()")
        XCTAssert(root.owner === owner)
        XCTAssert(leftChild.owner === owner)
        XCTAssert(rightChild.owner === owner)
		print("<<< Exiting testOwner()")
    }
    
    func testNumberOfKeys() {
		print(">>> Entering testNumberOfKeys()")
        XCTAssertEqual(root.numberOfKeys, 1)
        XCTAssertEqual(leftChild.numberOfKeys, 0)
        XCTAssertEqual(rightChild.numberOfKeys, 0)
		print("<<< Exiting testNumberOfKeys()")
    }
    
    func testChildren() {
		print(">>> Entering testChildren()")
        XCTAssertEqual(root.children!.count, 2)
		print("<<< Exiting testChildren()")
    }
}
