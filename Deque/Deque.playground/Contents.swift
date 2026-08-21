//: Playground - noun: a place where people can play

public struct Deque<T> {
  private var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func enqueue(_ element: T) {
	print(">>> Entering enqueue(element=\(element))")
    array.append(element)
	print("<<< Exiting enqueue(element=\(element))")
  }

  public mutating func enqueueFront(_ element: T) {
	print(">>> Entering enqueueFront(element=\(element))")
    array.insert(element, at: 0)
	print("<<< Exiting enqueueFront(element=\(element))")
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
    return array.first
  }

  public func peekBack() -> T? {
	print(">>> Entering peekBack()")
    return array.last
  }
}

var deque = Deque<Int>()
deque.enqueue(1)
deque.enqueue(2)
deque.enqueue(3)
deque.enqueue(4)

deque.dequeue()       // 1
deque.dequeueBack()   // 4

deque.enqueueFront(5)
deque.dequeue()       // 5
