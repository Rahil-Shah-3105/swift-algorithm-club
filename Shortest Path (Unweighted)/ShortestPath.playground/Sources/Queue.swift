public struct Queue<T> {
  private var array: [T]

  public init() {
    array = []
  }

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func enqueue(element: T) {
	print(">>> Entering enqueue(element=\(element))")
    array.append(element)
	print("<<< Exiting enqueue(element=\(element))")
  }

  public mutating func dequeue() -> T? {
	print(">>> Entering dequeue()")
    if isEmpty {
      return nil
    } else {
	print("<<< Exiting dequeue()")
      return array.removeFirst()
    }
  }

  public func peek() -> T? {
	print(">>> Entering peek()")
    return array.first
  }
}
