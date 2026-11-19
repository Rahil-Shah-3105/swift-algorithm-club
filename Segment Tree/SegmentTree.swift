import Foundation
/*
  Segment tree

  Performance:
    building the tree is O(n)
    query is O(log n)
    replace item is O(log n)
*/

public class SegmentTree<T> {

	private var value: T
	private var function: (T, T) -> T
	private var leftBound: Int
	private var rightBound: Int
	private var leftChild: SegmentTree<T>?
	private var rightChild: SegmentTree<T>?

	public init(array: [T], leftBound: Int, rightBound: Int, function: @escaping (T, T) -> T) {
		self.leftBound = leftBound
		self.rightBound = rightBound
		self.function = function

		if leftBound == rightBound {
			value = array[leftBound]
		} else {
			let middle = (leftBound + rightBound) / 2
			leftChild = SegmentTree<T>(array: array, leftBound: leftBound, rightBound: middle, function: function)
			rightChild = SegmentTree<T>(array: array, leftBound: middle+1, rightBound: rightBound, function: function)
			value = function(leftChild!.value, rightChild!.value)
		}
	}

	public convenience init(array: [T], function: @escaping (T, T) -> T) {
		self.init(array: array, leftBound: 0, rightBound: array.count-1, function: function)
	}

	public func query(leftBound: Int, rightBound: Int) -> T {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering query(leftBound=\(leftBound),rightBound=\(rightBound))\n".utf8))
		if self.leftBound == leftBound && self.rightBound == rightBound {
			return self.value
		}

		guard let leftChild = leftChild else { fatalError("leftChild should not be nil") }
		FileHandle.standardError.write(Data("[ERROR] query(leftBound=\(leftBound),rightBound=\(rightBound)): leftChild → \(leftChild)\n".utf8))
		guard let rightChild = rightChild else { fatalError("rightChild should not be nil") }
		FileHandle.standardError.write(Data("[ERROR] query(leftBound=\(leftBound),rightBound=\(rightBound)): rightChild → \(rightChild)\n".utf8))

		if leftChild.rightBound < leftBound {
			return rightChild.query(leftBound: leftBound, rightBound: rightBound)
		} else if rightChild.leftBound > rightBound {
			return leftChild.query(leftBound: leftBound, rightBound: rightBound)
		} else {
			let leftResult = leftChild.query(leftBound: leftBound, rightBound: leftChild.rightBound)
			let rightResult = rightChild.query(leftBound:rightChild.leftBound, rightBound: rightBound)
			FileHandle.standardError.write(Data("[ERROR] query(leftBound=\(leftBound),rightBound=\(rightBound)): leftResult → \(leftResult)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting query(leftBound=\(leftBound),rightBound=\(rightBound))\n".utf8))
			return function(leftResult, rightResult)
		}
	}

	public func replaceItem(at index: Int, withItem item: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering replaceItem(index=\(index),item=\(item))\n".utf8))
		if leftBound == rightBound {
			value = item
		} else if let leftChild = leftChild, let rightChild = rightChild {
			if leftChild.rightBound >= index {
				leftChild.replaceItem(at: index, withItem: item)
			} else {
				rightChild.replaceItem(at: index, withItem: item)
			}
			value = function(leftChild.value, rightChild.value)
		}
		FileHandle.standardError.write(Data("[WARN] <<< Exiting replaceItem(index=\(index),item=\(item))\n".utf8))
	}
}
