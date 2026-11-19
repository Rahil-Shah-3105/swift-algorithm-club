import Foundation
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enqueue(element=\(element))\n".utf8))
    array.append(element)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enqueue(element=\(element))\n".utf8))
  }

  public mutating func enqueueFront(_ element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enqueueFront(element=\(element))\n".utf8))
    if head == 0 {
      capacity *= 2
      let emptySpace = [T?](repeating: nil, count: capacity)
      array.insert(contentsOf: emptySpace, at: 0)
      head = capacity
	FileHandle.standardError.write(Data("[ERROR] enqueueFront(element=\(element)): emptySpace → \(emptySpace)\n".utf8))
    }

    head -= 1
    array[head] = element
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enqueueFront(element=\(element))\n".utf8))
  }

  public mutating func dequeue() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering dequeue()\n".utf8))
    guard head < array.count, let element = array[head] else { return nil }

    array[head] = nil
    head += 1

    if capacity >= originalCapacity && head >= capacity*2 {
      let amountToRemove = capacity + capacity/2
      array.removeFirst(amountToRemove)
      head -= amountToRemove
      capacity /= 2
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting dequeue()\n".utf8))
    return element
  }

  public mutating func dequeueBack() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering dequeueBack()\n".utf8))
    if isEmpty {
      return nil
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting dequeueBack()\n".utf8))
      return array.removeLast()
    }
  }

  public func peekFront() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering peekFront()\n".utf8))
    if isEmpty {
      return nil
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting peekFront()\n".utf8))
      return array[head]
    }
  }

  public func peekBack() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering peekBack()\n".utf8))
    if isEmpty {
      return nil
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting peekBack()\n".utf8))
      return array.last!
    }
  }
}
