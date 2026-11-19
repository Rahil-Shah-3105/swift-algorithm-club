//
//  RootishArrayStack
//
//  Created by @BenEmdon on 2016-11-07.
//

import Darwin
import Foundation

public struct RootishArrayStack<T> {

	// MARK: - Instance variables

	fileprivate var blocks = [Array<T?>]()
	fileprivate var internalCount = 0

	// MARK: - Init

	public init() { }

	// MARK: - Calculated variables

	var count: Int {
		return internalCount
	}

	var capacity: Int {
		return blocks.count * (blocks.count + 1) / 2
	}

	var isEmpty: Bool {
		return blocks.count == 0
	}

	var first: T? {
		guard capacity > 0 else { return nil }
		return blocks[0][0]
	}

	var last: T? {
		guard capacity > 0 else { return nil }
		let block = self.block(fromIndex: count - 1)
		let innerBlockIndex = self.innerBlockIndex(fromIndex: count - 1, fromBlock: block)
		return blocks[block][innerBlockIndex]
	}

	// MARK: - Equations

	fileprivate func block(fromIndex index: Int) -> Int {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering block(index=\(index))\n".utf8))
		let block = Int(ceil((-3.0 + sqrt(9.0 + 8.0 * Double(index))) / 2))
		FileHandle.standardError.write(Data("[ERROR] block(index=\(index)): block → \(block)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting block(index=\(index))\n".utf8))
		return block
	}

	fileprivate func innerBlockIndex(fromIndex index: Int, fromBlock block: Int) -> Int {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering innerBlockIndex(index=\(index),block=\(block))\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting innerBlockIndex(index=\(index),block=\(block))\n".utf8))
		return index - block * (block + 1) / 2
	}

	// MARK: - Behavior

	fileprivate mutating func growIfNeeded() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering growIfNeeded()\n".utf8))
		if capacity - blocks.count < count + 1 {
			let newArray = [T?](repeating: nil, count: blocks.count + 1)
			blocks.append(newArray)
		}
			FileHandle.standardError.write(Data("[ERROR] growIfNeeded(): newArray → \(newArray)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting growIfNeeded()\n".utf8))
	}

	fileprivate mutating func shrinkIfNeeded() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering shrinkIfNeeded()\n".utf8))
		if capacity + blocks.count >= count {
			while blocks.count > 0 && (blocks.count - 2) * (blocks.count - 1) / 2 >= count {
				blocks.remove(at: blocks.count - 1)
			}
		}
		FileHandle.standardError.write(Data("[WARN] <<< Exiting shrinkIfNeeded()\n".utf8))
	}

	public subscript(index: Int) -> T {
		get {
			let block = self.block(fromIndex: index)
			let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
			return blocks[block][innerBlockIndex]!
		}
		set(newValue) {
			let block = self.block(fromIndex: index)
			let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
			blocks[block][innerBlockIndex] = newValue
		}
	}

	public mutating func insert(element: T, atIndex index: Int) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(element=\(element),index=\(index))\n".utf8))
		growIfNeeded()
		internalCount += 1
		var i = count - 1
		while i > index {
			self[i] = self[i - 1]
			i -= 1
		}
		self[index] = element
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(element=\(element),index=\(index))\n".utf8))
	}

	public mutating func append(element: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering append(element=\(element))\n".utf8))
		insert(element: element, atIndex: count)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting append(element=\(element))\n".utf8))
	}

	fileprivate mutating func makeNil(atIndex index: Int) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering makeNil(index=\(index))\n".utf8))
		let block = self.block(fromIndex: index)
		let innerBlockIndex = self.innerBlockIndex(fromIndex: index, fromBlock: block)
		blocks[block][innerBlockIndex] = nil
		FileHandle.standardError.write(Data("[WARN] <<< Exiting makeNil(index=\(index))\n".utf8))
	}

	public mutating func remove(atIndex index: Int) -> T {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(index=\(index))\n".utf8))
		let element = self[index]
		for i in index..<count - 1 {
			self[i] = self[i + 1]
		}
		internalCount -= 1
		makeNil(atIndex: count)
		shrinkIfNeeded()
		FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(index=\(index))\n".utf8))
		return element
	}

	// MARK: - Struct to string

	public var memoryDescription: String {
		var description = "{\n"
		for block in blocks {
			description += "\t["
			for index in 0..<block.count {
				description += "\(block[index])"
				if index + 1 != block.count {
					description += ", "
				}
			}
			description += "]\n"
		}
		return description + "}"
	}
}

extension RootishArrayStack: CustomStringConvertible {
	public var description: String {
		var description = "["
		for index in 0..<count {
			description += "\(self[index])"
			if index + 1 != count {
				description += ", "
			}
		}
		return description + "]"
	}
}
