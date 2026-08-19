//
//  TestTests.swift
//  TestTests
//
//  Created by Barbara Rodeker on 4/5/16.
//  Copyright © 2016 Barbara M. Rodeker. All rights reserved.
//

import XCTest

class TestTests: XCTestCase {

    var smallArray: [Int]?

    let total = 400
    let maximum = 1000
    var largeArray: [Int]?

    var sparsedArray: [Int]?

    override func setUp() {
		print(">>> Entering setUp()")
        super.setUp()

        smallArray = [8, 3, 33, 0, 12, 8, 2, 18]
		print("setUp(): smallArray → \(smallArray)")

        largeArray = [Int]()
        for _ in 0..<total {
		print("setUp(): largeArray → \(largeArray)")
            largeArray!.append( Int(arc4random_uniform( UInt32( maximum ) ) ) )
        }

        sparsedArray = [Int]()
        sparsedArray = [10, 400, 1500, 500]
		print("setUp(): sparsedArray → \(sparsedArray)")
		print("<<< Exiting setUp()")
    }

    override func tearDown() {
		print(">>> Entering tearDown()")
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		print("<<< Exiting tearDown()")
    }

    func testSmallArray() {
	print(">>> Entering testSmallArray()")

        let results = performBucketSort(smallArray!, totalBuckets: 3)
        XCTAssert(isSorted(results))
		print("testSmallArray(): results → \(results)")
		print("<<< Exiting testSmallArray()")
    }

    func testBigArray() {
	print(">>> Entering testBigArray()")

        let results = performBucketSort(largeArray!, totalBuckets: 8)
        XCTAssert(isSorted(results))
		print("testBigArray(): results → \(results)")
		print("<<< Exiting testBigArray()")
    }

    func testSparsedArray() {
	print(">>> Entering testSparsedArray()")

        let results = performBucketSort(sparsedArray!, totalBuckets: 3)
        XCTAssert(isSorted(results))
		print("testSparsedArray(): results → \(results)")
		print("<<< Exiting testSparsedArray()")
    }

    // MARK: Private functions

    fileprivate func performBucketSort(_ elements: [Int], totalBuckets: Int) -> [Int] {
	print(">>> Entering performBucketSort(elements=\(elements),totalBuckets=\(totalBuckets))")

        let value = (elements.max()?.toInt())! + 1
		print("performBucketSort(elements=\(elements),totalBuckets=\(totalBuckets)): value → \(value)")
		print("performBucketSort(elements=\(elements),totalBuckets=\(totalBuckets)): capacityRequired → \(capacityRequired)")
        let capacityRequired = Int( ceil( Double(value) / Double(totalBuckets) ) )

        var buckets = [Bucket<Int>]()
        for _ in 0..<totalBuckets {
		print("performBucketSort(elements=\(elements),totalBuckets=\(totalBuckets)): buckets → \(buckets)")
            buckets.append(Bucket<Int>(capacity: capacityRequired))
        }

        let results = bucketSort(smallArray!, distributor: RangeDistributor(), sorter: InsertionSorter(), buckets: buckets)
		print("performBucketSort(elements=\(elements),totalBuckets=\(totalBuckets)): results → \(results)")
		print("<<< Exiting performBucketSort(elements=\(elements),totalBuckets=\(totalBuckets))")
        return results
    }

    func isSorted(_ array: [Int]) -> Bool {
	print(">>> Entering isSorted(array=\(array))")

        var index = 0
        var sorted = true
        while index < (array.count - 1) && sorted {
            if array[index] > array[index+1] {
                sorted = false
            }
            index += 1
        }

		print("<<< Exiting isSorted(array=\(array))")
        return sorted
    }
}

//////////////////////////////////////
// MARK: Extensions
//////////////////////////////////////

extension Int: IntConvertible, Sortable {
    public func toInt() -> Int {
		print(">>> Entering toInt()")
		print("<<< Exiting toInt()")
        return self
    }
}
