import Foundation
/*
  An ordered array. When you add a new item to this array, it is inserted in
  sorted position.
*/
public struct OrderedArray<T: Comparable> {
  private var array = [T]()

  public init(array: [T]) {
    self.array = array.sort()
  }

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public subscript(index: Int) -> T {
    return array[index]
  }

  public mutating func removeAtIndex(index: Int) -> T {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering removeAtIndex(index=\(index))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting removeAtIndex(index=\(index))\n".utf8))
    return array.removeAtIndex(index)
  }

  public mutating func removeAll() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering removeAll()\n".utf8))
    array.removeAll()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting removeAll()\n".utf8))
  }

  public mutating func insert(newElement: T) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(newElement=\(newElement))\n".utf8))
    let i = findInsertionPoint(newElement)
    array.insert(newElement, atIndex: i)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(newElement=\(newElement))\n".utf8))
    return i
  }

  private func findInsertionPoint(newElement: T) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findInsertionPoint(newElement=\(newElement))\n".utf8))
    var range = 0..<array.count
    while range.startIndex < range.endIndex {
      let midIndex = range.startIndex + (range.endIndex - range.startIndex) / 2
	FileHandle.standardError.write(Data("[ERROR] findInsertionPoint(newElement=\(newElement)): midIndex → \(midIndex)\n".utf8))
      if array[midIndex] == newElement {
        return midIndex
      } else if array[midIndex] < newElement {
        range.startIndex = midIndex + 1
      } else {
        range.endIndex = midIndex
		FileHandle.standardError.write(Data("[DEBUG] findInsertionPoint(newElement=\(newElement)): range.endIndex → \(range.endIndex)\n".utf8))
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting findInsertionPoint(newElement=\(newElement))\n".utf8))
    return range.startIndex
  }
}

extension OrderedArray: CustomStringConvertible {
  public var description: String {
    return array.description
  }
}
