import Foundation
/*
  First-in first-out queue (FIFO)

  New elements are added to the end of the queue. Dequeuing pulls elements from
  the front of the queue.

  Enqueuing is an O(1) operation, dequeuing is O(n). Note: If the queue had been
  implemented with a linked list, then both would be O(1).
*/
public struct Queue<T> {
  fileprivate var array = [T]()

  public var count: Int {
    return array.count
  }

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public mutating func enqueue(_ element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enqueue(element=\(element))\n".utf8))
    array.append(element)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enqueue(element=\(element))\n".utf8))
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

  public var front: T? {
    return array.first
  }
}
