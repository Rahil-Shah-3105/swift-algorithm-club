import Foundation
public final class LinkedList<T> {

    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        weak var previous: LinkedListNode?

        public init(value: T) {
            self.value = value
        }
    }

    public typealias Node = LinkedListNode<T>

    fileprivate var head: Node?

    public init() {}

    public var isEmpty: Bool {
        return head == nil
    }

    public var first: Node? {
        return head
    }

    public var last: Node? {
        if var node = head {
            while let next = node.next {
                node = next
            }
            return node
        } else {
            return nil
        }
    }

    public var count: Int {
        if var node = head {
            var c = 1
            while let next = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
    }

    public func node(atIndex index: Int) -> Node? {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering node(index=\(index))\n".utf8))
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting node(index=\(index))\n".utf8))
        return nil
    }

    public subscript(index: Int) -> T {
        let node = self.node(atIndex: index)
        assert(node != nil)
        return node!.value
    }

    public func append(_ value: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering append(value=\(value))\n".utf8))
        let newNode = Node(value: value)
        self.append(newNode)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting append(value=\(value))\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] append(value=\(value)): newNode → \(newNode)\n".utf8))
    }

    public func append(_ node: Node) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering append(node=\(node))\n".utf8))
        let newNode = LinkedListNode(value: node.value)
        if let lastNode = last {
			FileHandle.standardError.write(Data("[ERROR] append(node=\(node)): newNode → \(newNode)\n".utf8))
            newNode.previous = lastNode
			FileHandle.standardError.write(Data("[DEBUG] append(node=\(node)): newNode.previous → \(newNode.previous)\n".utf8))
            lastNode.next = newNode
        } else {
            head = newNode
			FileHandle.standardError.write(Data("[DEBUG] append(node=\(node)): head → \(head)\n".utf8))
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting append(node=\(node))\n".utf8))
    }

    public func append(_ list: LinkedList) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering append(list=\(list))\n".utf8))
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            self.append(node.value)
            nodeToCopy = node.next
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting append(list=\(list))\n".utf8))
    }

    private func nodesBeforeAndAfter(index: Int) -> (Node?, Node?) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering nodesBeforeAndAfter(index=\(index))\n".utf8))
        assert(index >= 0)

        var i = index
        var next = head
        var prev: Node?

        while next != nil && i > 0 {
            i -= 1
            prev = next
			FileHandle.standardError.write(Data("[DEBUG] nodesBeforeAndAfter(index=\(index)): prev → \(prev)\n".utf8))
            next = next!.next
        }
        assert(i == 0)  // if > 0, then specified index was too large

		FileHandle.standardError.write(Data("[WARN] <<< Exiting nodesBeforeAndAfter(index=\(index))\n".utf8))
        return (prev, next)
    }

    public func insert(_ value: T, atIndex index: Int) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(value=\(value),index=\(index))\n".utf8))
        let newNode = Node(value: value)
        self.insert(newNode, atIndex: index)
		FileHandle.standardError.write(Data("[ERROR] insert(value=\(value),index=\(index)): newNode → \(newNode)\n".utf8))
    }

    public func insert(_ node: Node, atIndex index: Int) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(node=\(node),index=\(index))\n".utf8))
        let (prev, next) = nodesBeforeAndAfter(index: index)
        let newNode = LinkedListNode(value: node.value)
        newNode.previous = prev
		FileHandle.standardError.write(Data("[DEBUG] insert(node=\(node),index=\(index)): newNode.previous → \(newNode.previous)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(value=\(value),index=\(index))\n".utf8))
        newNode.next = next
		FileHandle.standardError.write(Data("[DEBUG] insert(node=\(node),index=\(index)): newNode.next → \(newNode.next)\n".utf8))
        prev?.next = newNode
        next?.previous = newNode

        if prev == nil {
            head = newNode
			FileHandle.standardError.write(Data("[DEBUG] insert(node=\(node),index=\(index)): head → \(head)\n".utf8))
        }
    }

    public func insert(_ list: LinkedList, atIndex index: Int) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(list=\(list),index=\(index))\n".utf8))
        if list.isEmpty { return }
        var (prev, next) = nodesBeforeAndAfter(index: index)
        var nodeToCopy = list.head
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(node=\(node),index=\(index))\n".utf8))
        var newNode: Node?
        while let node = nodeToCopy {
            newNode = Node(value: node.value)
            newNode?.previous = prev
			FileHandle.standardError.write(Data("[DEBUG] insert(list=\(list),index=\(index)): newNode → \(newNode)\n".utf8))
            if let previous = prev {
                previous.next = newNode
            } else {
                self.head = newNode
				FileHandle.standardError.write(Data("[DEBUG] insert(list=\(list),index=\(index)): self.head → \(self.head)\n".utf8))
            }
            nodeToCopy = nodeToCopy?.next
            prev = newNode
			FileHandle.standardError.write(Data("[DEBUG] insert(list=\(list),index=\(index)): prev → \(prev)\n".utf8))
        }
        prev?.next = next
        next?.previous = prev
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(list=\(list),index=\(index))\n".utf8))
    }

    public func removeAll() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering removeAll()\n".utf8))
        head = nil
		FileHandle.standardError.write(Data("[DEBUG] removeAll(): head → \(head)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting removeAll()\n".utf8))
    }

    @discardableResult public func remove(node: Node) -> T {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(node=\(node))\n".utf8))
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
			FileHandle.standardError.write(Data("[DEBUG] remove(node=\(node)): head → \(head)\n".utf8))
        }
        next?.previous = prev

		FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(node=\(node))\n".utf8))
        node.previous = nil
		FileHandle.standardError.write(Data("[DEBUG] remove(node=\(node)): node.previous → \(node.previous)\n".utf8))
        node.next = nil
		FileHandle.standardError.write(Data("[DEBUG] remove(node=\(node)): node.next → \(node.next)\n".utf8))
        return node.value
		FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(index=\(index))\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] remove(index=\(index)): node → \(node)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(index=\(index))\n".utf8))
    }

    @discardableResult public func removeLast() -> T {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering removeLast()\n".utf8))
        assert(!isEmpty)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting removeLast()\n".utf8))
        return remove(node: last!)
    }

    @discardableResult public func remove(atIndex index: Int) -> T {
        let node = self.node(atIndex: index)
        assert(node != nil)
        return remove(node: node!)
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
}

extension LinkedList {
    public func reverse() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering reverse()\n".utf8))
        var node = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
			FileHandle.standardError.write(Data("[DEBUG] reverse(): head → \(head)\n".utf8))
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting reverse()\n".utf8))
    }
}

extension LinkedList {
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering map(transform=\(transform))\n".utf8))
        let result = LinkedList<U>()
        var node = head
		FileHandle.standardError.write(Data("[ERROR] map(transform=\(transform)): result → \(result)\n".utf8))
        while node != nil {
            result.append(transform(node!.value))
            node = node!.next
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting map(transform=\(transform))\n".utf8))
        return result
    }

    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering filter(predicate=\(predicate))\n".utf8))
        let result = LinkedList<T>()
        var node = head
		FileHandle.standardError.write(Data("[ERROR] filter(predicate=\(predicate)): result → \(result)\n".utf8))
        while node != nil {
            if predicate(node!.value) {
                result.append(node!.value)
            }
            node = node!.next
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting filter(predicate=\(predicate))\n".utf8))
        return result
    }
}

extension LinkedList {
    convenience init(array: Array<T>) {
        self.init()

        for element in array {
            self.append(element)
        }
    }
}

extension LinkedList: ExpressibleByArrayLiteral {
  public convenience init(arrayLiteral elements: T...) {
    self.init()

    for element in elements {
      self.append(element)
    }
  }
}
