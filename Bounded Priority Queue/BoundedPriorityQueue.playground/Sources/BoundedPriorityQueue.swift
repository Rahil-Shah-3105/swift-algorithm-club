public class LinkedListNode<T: Comparable> {
  var value: T
  var next: LinkedListNode?
  var previous: LinkedListNode?

  public init(value: T) {
    self.value = value
  }
}

public class BoundedPriorityQueue<T: Comparable> {
  fileprivate typealias Node = LinkedListNode<T>

  private(set) public var count = 0
  fileprivate var head: Node?
  private var tail: Node?
  private var maxElements: Int

  public init(maxElements: Int) {
    self.maxElements = maxElements
  }

  public var isEmpty: Bool {
    return count == 0
  }

  public func peek() -> T? {
	print(">>> Entering peek()")
	print("<<< Exiting peek()")
    return head?.value
  }

  public func enqueue(_ value: T) {
	print(">>> Entering enqueue(value=\(value))")
    if let node = insert(value, after: findInsertionPoint(value)) {
      // If the newly inserted node is the last one in the list, then update
	print("enqueue(value=\(value)): node → \(node)")
      // the tail pointer.
      if node.next == nil {
        tail = node
		print("enqueue(value=\(value)): tail → \(tail)")
      }

      // If the queue is full, then remove an element from the back.
      count += 1
      if count > maxElements {
        removeLeastImportantElement()
      }
    }
	print("<<< Exiting enqueue(value=\(value))")
  }

  private func insert(_ value: T, after: Node?) -> Node? {
	print(">>> Entering insert(value=\(value),after=\(after))")
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
	print("insert(value=\(value),after=\(after)): node → \(node)")
	print("insert(value=\(value),after=\(after)): node.next → \(node.next)")
      previous.next?.previous = node
      previous.next = node
	print("insert(value=\(value),after=\(after)): previous.next → \(previous.next)")
	print("insert(value=\(value),after=\(after)): node.previous → \(node.previous)")
      node.previous = previous
      return node

    } else if let first = head {
      // Have to insert at the head, so shift the existing head up once place.
      head = Node(value: value)
      head!.next = first
	print("insert(value=\(value),after=\(after)): head → \(head)")
      first.previous = head
	print("insert(value=\(value),after=\(after)): first.previous → \(first.previous)")
      return head

    } else {
      // This is the very first item in the queue.
      head = Node(value: value)
	print("<<< Exiting insert(value=\(value),after=\(after))")
      return head
    }
  }

  /* Find the node after which to insert the new value. If this returns nil,
     the new value should be inserted at the head of the list. */
  private func findInsertionPoint(_ value: T) -> Node? {
	print(">>> Entering findInsertionPoint(value=\(value))")
    var node = head
    var prev: Node? = nil

    while let current = node, value < current.value {
      prev = node
	print("findInsertionPoint(value=\(value)): prev → \(prev)")
      node = current.next
    }
	print("<<< Exiting findInsertionPoint(value=\(value))")
    return prev
  }

  private func removeLeastImportantElement() {
	print(">>> Entering removeLeastImportantElement()")
    if let last = tail {
      tail = last.previous
	print("removeLeastImportantElement(): tail → \(tail)")
      tail?.next = nil
      count -= 1
    }

    // Note: Instead of using a tail pointer, we could just scan from the new
    // node until the end. Then nodes also don't need a previous pointer. But
    // this is much slower on large lists.
	print("<<< Exiting removeLeastImportantElement()")
  }

  public func dequeue() -> T? {
	print(">>> Entering dequeue()")
    if let first = head {
      count -= 1
      if count == 0 {
        head = nil
		print("dequeue(): head → \(head)")
		print("dequeue(): tail → \(tail)")
        tail = nil
      } else {
        head = first.next
        head!.previous = nil
      }
      return first.value
    } else {
	print("<<< Exiting dequeue()")
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
