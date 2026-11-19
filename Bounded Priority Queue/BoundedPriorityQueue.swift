import Foundation
open class LinkedListNode<T: Comparable> {
  var value: T
  var next: LinkedListNode?
  var previous: LinkedListNode?

  public init(value: T) {
    self.value = value
  }
}

open class BoundedPriorityQueue<T: Comparable> {
  fileprivate typealias Node = LinkedListNode<T>

  fileprivate(set) open var count = 0
  fileprivate var head: Node?
  fileprivate var tail: Node?
  fileprivate var maxElements: Int

  public init(maxElements: Int) {
    self.maxElements = maxElements
  }

  open var isEmpty: Bool {
    return count == 0
  }

  open func peek() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering peek()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting peek()\n".utf8))
    return head?.value
  }

  open func enqueue(_ value: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering enqueue(value=\(value))\n".utf8))
    if let node = insert(value, after: findInsertionPoint(value)) {
      // If the newly inserted node is the last one in the list, then update
      // the tail pointer.
      if node.next == nil {
        tail = node
		FileHandle.standardError.write(Data("[DEBUG] enqueue(value=\(value)): tail → \(tail)\n".utf8))
      }

      // If the queue is full, then remove an element from the back.
      count += 1
      if count > maxElements {
        removeLeastImportantElement()
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting enqueue(value=\(value))\n".utf8))
  }

  fileprivate func insert(_ value: T, after: Node?) -> Node? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(value=\(value),after=\(after))\n".utf8))
    if let previous = after {

      // If the queue is full and we have to insert at the end of the list,
      // then there's no reason to insert the new value.
      if count == maxElements && previous.next == nil {
        print("Queue is full and priority of new object is too small")
        return nil
      }

      // Put the new node in between previous and previous.next (if exists).
      let node = Node(value: value)
      node.next = previous.next
	FileHandle.standardError.write(Data("[DEBUG] insert(value=\(value),after=\(after)): node.next → \(node.next)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] insert(value=\(value),after=\(after)): node → \(node)\n".utf8))
      previous.next?.previous = node
      previous.next = node
	FileHandle.standardError.write(Data("[DEBUG] insert(value=\(value),after=\(after)): previous.next → \(previous.next)\n".utf8))
      node.previous = previous
	FileHandle.standardError.write(Data("[DEBUG] insert(value=\(value),after=\(after)): node.previous → \(node.previous)\n".utf8))
      return node

    } else if let first = head {
      // Have to insert at the head, so shift the existing head up once place.
      head = Node(value: value)
      head!.next = first
	FileHandle.standardError.write(Data("[DEBUG] insert(value=\(value),after=\(after)): head → \(head)\n".utf8))
      first.previous = head
	FileHandle.standardError.write(Data("[DEBUG] insert(value=\(value),after=\(after)): first.previous → \(first.previous)\n".utf8))
      return head

    } else {
      // This is the very first item in the queue.
      head = Node(value: value)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(value=\(value),after=\(after))\n".utf8))
      return head
    }
  }

  /* Find the node after which to insert the new value. If this returns nil,
   the new value should be inserted at the head of the list. */
  fileprivate func findInsertionPoint(_ value: T) -> Node? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findInsertionPoint(value=\(value))\n".utf8))
    var node = head
    var prev: Node? = nil

    while let current = node, value < current.value {
      prev = node
      node = current.next
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting findInsertionPoint(value=\(value))\n".utf8))
    return prev
  }

  fileprivate func removeLeastImportantElement() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering removeLeastImportantElement()\n".utf8))
    if let last = tail {
      tail = last.previous
	FileHandle.standardError.write(Data("[DEBUG] removeLeastImportantElement(): tail → \(tail)\n".utf8))
      tail?.next = nil
      count -= 1
    }

    // Note: Instead of using a tail pointer, we could just scan from the new
    // node until the end. Then nodes also don't need a previous pointer. But
    // this is much slower on large lists.
	FileHandle.standardError.write(Data("[WARN] <<< Exiting removeLeastImportantElement()\n".utf8))
  }

  open func dequeue() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering dequeue()\n".utf8))
    if let first = head {
      count -= 1
      if count == 0 {
        head = nil
		FileHandle.standardError.write(Data("[DEBUG] dequeue(): head → \(head)\n".utf8))
        tail = nil
      } else {
        head = first.next
        head!.previous = nil
      }
      return first.value
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting dequeue()\n".utf8))
      return nil
    }
  }
}

extension LinkedListNode: CustomStringConvertible {
  public var description: String {
    return "\(value)"
  }
}

extension BoundedPriorityQueue: CustomStringConvertible {
  public var description: String {
    var s = "<"
    var node = head
    while let current = node {
      s += "\(current), "
      node = current.next
    }
    return s + ">"
  }
}
