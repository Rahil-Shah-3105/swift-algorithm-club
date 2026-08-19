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
	print(">>> Entering removeAtIndex(index=\(index))")
	print("<<< Exiting removeAtIndex(index=\(index))")
    return array.removeAtIndex(index)
  }

  public mutating func removeAll() {
	print(">>> Entering removeAll()")
    array.removeAll()
	print("<<< Exiting removeAll()")
  }

  public mutating func insert(newElement: T) -> Int {
	print(">>> Entering insert(newElement=\(newElement))")
    let i = findInsertionPoint(newElement)
    array.insert(newElement, atIndex: i)
	print("<<< Exiting insert(newElement=\(newElement))")
    return i
  }

  private func findInsertionPoint(newElement: T) -> Int {
	print(">>> Entering findInsertionPoint(newElement=\(newElement))")
    var range = 0..<array.count
    while range.startIndex < range.endIndex {
      let midIndex = range.startIndex + (range.endIndex - range.startIndex) / 2
	print("findInsertionPoint(newElement=\(newElement)): midIndex → \(midIndex)")
      if array[midIndex] == newElement {
        return midIndex
      } else if array[midIndex] < newElement {
        range.startIndex = midIndex + 1
		print("findInsertionPoint(newElement=\(newElement)): range.startIndex → \(range.startIndex)")
      } else {
        range.endIndex = midIndex
		print("findInsertionPoint(newElement=\(newElement)): range.endIndex → \(range.endIndex)")
      }
    }
	print("<<< Exiting findInsertionPoint(newElement=\(newElement))")
    return range.startIndex
  }
}

extension OrderedArray: CustomStringConvertible {
  public var description: String {
    return array.description
  }
}
