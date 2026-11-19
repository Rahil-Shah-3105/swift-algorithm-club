import Foundation
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enqueue(element=\(element))\n".utf8))
    array.append(element)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enqueue(element=\(element))\n".utf8))
  }

  public mutating func enqueueFront(_ element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enqueueFront(element=\(element))\n".utf8))
    array.insert(element, at: 0)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enqueueFront(element=\(element))\n".utf8))
  }

  public mutating func dequeue() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering dequeue()\n".utf8))
    if isEmpty {
      return nil
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting dequeue()\n".utf8))
      return array.removeFirst()
    }
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
    FileHandle.standardError.write(Data("[WARN] <<< Exiting peekFront()\n".utf8))
    return array.first
  }

  public func peekBack() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering peekBack()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting peekBack()\n".utf8))
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
