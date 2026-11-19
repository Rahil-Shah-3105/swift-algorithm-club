import Foundation
//
//  BucketSort.swift
//
//  Created by Barbara Rodeker on 4/4/16.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
//  EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
//  AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
//  OR OTHER DEALINGS IN THE SOFTWARE.
//
//

//////////////////////////////////////
// MARK: Main algorithm
//////////////////////////////////////

/**
    Performs bucket sort algorithm on the given input elements.
    [Bucket Sort Algorithm Reference](https://en.wikipedia.org/wiki/Bucket_sort)

    - Parameter elements:     Array of Sortable elements
    - Parameter distributor:  Performs the distribution of each element of a bucket
    - Parameter sorter:       Performs the sorting inside each bucket, after all the elements are distributed
    - Parameter buckets:      An array of buckets

    - Returns: A new array with sorted elements
 */

public func bucketSort<T>(_ elements: [T], distributor: Distributor, sorter: Sorter, buckets: [Bucket<T>]) -> [T] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering bucketSort(elements=\(elements),distributor=\(distributor),sorter=\(sorter),buckets=\(buckets))\n".utf8))
    precondition(allPositiveNumbers(elements))
    precondition(enoughSpaceInBuckets(buckets, elements: elements))

    var bucketsCopy = buckets
    for elem in elements {
        distributor.distribute(elem, buckets: &bucketsCopy)
    }

    var results = [T]()

	FileHandle.standardError.write(Data("[ERROR] bucketSort(elements=\(elements),distributor=\(distributor),sorter=\(sorter),buckets=\(buckets)): results → \(results)\n".utf8))
    for bucket in bucketsCopy {
        results += bucket.sort(sorter)
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting bucketSort(elements=\(elements),distributor=\(distributor),sorter=\(sorter),buckets=\(buckets))\n".utf8))
    return results
}

private func allPositiveNumbers<T: Sortable>(_ array: [T]) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering allPositiveNumbers(array=\(array))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting allPositiveNumbers(array=\(array))\n".utf8))
    return array.filter { $0.toInt() >= 0 }.count > 0
}

private func enoughSpaceInBuckets<T>(_ buckets: [Bucket<T>], elements: [T]) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enoughSpaceInBuckets(buckets=\(buckets),elements=\(elements))\n".utf8))
    let maximumValue = elements.max()?.toInt()
    let totalCapacity = buckets.count * (buckets.first?.capacity)!
	FileHandle.standardError.write(Data("[ERROR] enoughSpaceInBuckets(buckets=\(buckets),elements=\(elements)): totalCapacity → \(totalCapacity)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] enoughSpaceInBuckets(buckets=\(buckets),elements=\(elements)): maximumValue → \(maximumValue)\n".utf8))

    guard let max = maximumValue else {
        return false
    }
    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enoughSpaceInBuckets(buckets=\(buckets),elements=\(elements))\n".utf8))
    return totalCapacity >= max
}

//////////////////////////////////////
// MARK: Distributor
//////////////////////////////////////

public protocol Distributor {
    func distribute<T>(_ element: T, buckets: inout [Bucket<T>])
}

/*
 * An example of a simple distribution function that send every elements to
 * the bucket representing the range in which it fits.An
 *
 * If the range of values to sort is 0..<49 i.e, there could be 5 buckets of capacity = 10
 * So every element will be classified by the ranges:
 *
 * -  0 ..< 10
 * - 10 ..< 20
 * - 20 ..< 30
 * - 30 ..< 40
 * - 40 ..< 50
 *
 * By following the formula: element / capacity = #ofBucket
 */
public struct RangeDistributor: Distributor {

    public init() {}

    public func distribute<T>(_ element: T, buckets: inout [Bucket<T>]) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering distribute(element=\(element),buckets=\(buckets))\n".utf8))
        let value = element.toInt()
        let bucketCapacity = buckets.first!.capacity
		FileHandle.standardError.write(Data("[ERROR] distribute(element=\(element),buckets=\(buckets)): value → \(value)\n".utf8))

        let bucketIndex = value / bucketCapacity
        buckets[bucketIndex].add(element)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting distribute(element=\(element),buckets=\(buckets))\n".utf8))
    }
}

//////////////////////////////////////
// MARK: Sortable
//////////////////////////////////////

public protocol IntConvertible {
    func toInt() -> Int
}

public protocol Sortable: IntConvertible, Comparable {
}

//////////////////////////////////////
// MARK: Sorter
//////////////////////////////////////

public protocol Sorter {
    func sort<T: Sortable>(_ items: [T]) -> [T]
}

public struct InsertionSorter: Sorter {

    public init() {}

    public func sort<T: Sortable>(_ items: [T]) -> [T] {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering sort(items=\(items))\n".utf8))
        var results = items
        for i in 0 ..< results.count {
			FileHandle.standardError.write(Data("[ERROR] sort(items=\(items)): results → \(results)\n".utf8))
            var j = i
            while j > 0 && results[j-1] > results[j] {

                let auxiliar = results[j-1]
                results[j-1] = results[j]
                results[j] = auxiliar

                j -= 1
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting sort(items=\(items))\n".utf8))
        return results
    }
}

//////////////////////////////////////
// MARK: Bucket
//////////////////////////////////////

public struct Bucket<T: Sortable> {
    var elements: [T]
    let capacity: Int

    public init(capacity: Int) {
        self.capacity = capacity
        elements = [T]()
    }

    public mutating func add(_ item: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering add(item=\(item))\n".utf8))
        if elements.count < capacity {
            elements.append(item)
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting add(item=\(item))\n".utf8))
    }

    public func sort(_ algorithm: Sorter) -> [T] {
        return algorithm.sort(elements)
    }
}
