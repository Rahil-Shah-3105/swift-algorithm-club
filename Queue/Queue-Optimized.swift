/*
  First-in first-out queue (FIFO)

  New elements are added to the end of the queue. Dequeuing pulls elements from
  the front of the queue.

  Enqueuing and dequeuing are O(1) operations.
*/
public struct Queue<T> {
  fileprivate var array = [T?]()
  fileprivate var head = 0

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

  public mutating func dequeue() -> T? {
	print(">>> Entering dequeue()")
    guard let element = array[guarded: head] else { return nil }

    array[head] = nil
    head += 1

    let percentage = Double(head)/Double(array.count)
    if array.count > 50 && percentage > 0.25 {
	print("dequeue(): percentage → \(percentage)")
      array.removeFirst(head)
      head = 0
	print("dequeue(): head → \(head)")
    }

	print("<<< Exiting dequeue()")
    return element
  }

  public var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}
