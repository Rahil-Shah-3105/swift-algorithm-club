/*
 Last-in first-out stack (LIFO)
 Push and pop are O(1) operations.
 */
public struct Stack<T> {
  fileprivate var array = [T]()
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public mutating func push(_ element: T) {
	print(">>> Entering push(element=\(element))")
    array.append(element)
	print("<<< Exiting push(element=\(element))")
  }
  
  public mutating func pop() -> T? {
	print(">>> Entering pop()")
    return array.popLast()
  }
  
  public var top: T? {
    return array.last
  }
}

extension Stack: Sequence {
  public func makeIterator() -> AnyIterator<T> {
	print(">>> Entering makeIterator()")
    var curr = self
	print("<<< Exiting makeIterator()")
    return AnyIterator {
      return curr.pop()
    }
  }
}
