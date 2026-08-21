/*
  Deque (pronounced "deck"), a double-ended queue

  All enqueuing and dequeuing operations are O(1).
*/
public struct Deque<T> {
  private var array: [T?]
  private var head: Int
  private var capacity: Int
  private let originalCapacity: Int

  public init(_ capacity: Int = 10) {
    self.capacity = max(capacity, 1)
    originalCapacity = self.capacity
    array = [T?](repeating: nil, count: capacity)
    head = capacity
  }

  public var isEmpty: Bool {
    return count == 0
  }

  public var count: Int {
    return array.count - head
  }

  public mutating func enqueue(_ element: T) {
	print(">>> Entering enqueue(element=\(element))")
    array.append(element)
	print("<<< Exiting enqueue(element=\(element))")
  }

  public mutating func enqueueFront(_ element: T) {
	print(">>> Entering enqueueFront(element=\(element))")
    if head == 0 {
      capacity *= 2
      let emptySpace = [T?](repeating: nil, count: capacity)
      array.insert(contentsOf: emptySpace, at: 0)
      head = capacity
	print("enqueueFront(element=\(element)): emptySpace → \(emptySpace)")
    }

    head -= 1
    array[head] = element
	print("<<< Exiting enqueueFront(element=\(element))")
  }

  public mutating func dequeue() -> T? {
	print(">>> Entering dequeue()")
    guard head < array.count, let element = array[head] else { return nil }

    array[head] = nil
    head += 1

    if capacity >= originalCapacity && head >= capacity*2 {
      let amountToRemove = capacity + capacity/2
      array.removeFirst(amountToRemove)
      head -= amountToRemove
      capacity /= 2
    }
	print("<<< Exiting dequeue()")
    return element
  }

  public mutating func dequeueBack() -> T? {
	print(">>> Entering dequeueBack()")
    if isEmpty {
      return nil
    } else {
	print("<<< Exiting dequeueBack()")
      return array.removeLast()
    }
  }

  public func peekFront() -> T? {
	print(">>> Entering peekFront()")
    if isEmpty {
      return nil
    } else {
	print("<<< Exiting peekFront()")
      return array[head]
    }
  }

  public func peekBack() -> T? {
	print(">>> Entering peekBack()")
    if isEmpty {
      return nil
    } else {
	print("<<< Exiting peekBack()")
      return array.last!
    }
  }
}
