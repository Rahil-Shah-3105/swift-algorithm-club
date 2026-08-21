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
			print("<<< Exiting node(index=\(index))")
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
			print(">>> Entering node(index=\(index))")
        }
    }

    public func node(atIndex index: Int) -> Node? {
		print(">>> Entering node(index=\(index))")
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node!.next
            }
        }
		print("<<< Exiting node(index=\(index))")
        return nil
    }

    public subscript(index: Int) -> T {
        let node = self.node(atIndex: index)
        assert(node != nil)
        return node!.value
    }

    public func append(_ value: T) {
		print(">>> Entering append(value=\(value))")
		print("append(value=\(value)): newNode → \(newNode)")
        let newNode = Node(value: value)
        self.append(newNode)
		print("<<< Exiting append(value=\(value))")
    }

    public func append(_ node: Node) {
		print(">>> Entering append(node=\(node))")
        let newNode = LinkedListNode(value: node.value)
        if let lastNode = last {
			print("append(node=\(node)): newNode → \(newNode)")
			print("append(node=\(node)): newNode.previous → \(newNode.previous)")
			print("append(node=\(node)): lastNode.next → \(lastNode.next)")
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
			print("append(node=\(node)): head → \(head)")
        }
		print("<<< Exiting append(node=\(node))")
    }

    public func append(_ list: LinkedList) {
		print(">>> Entering append(list=\(list))")
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            self.append(node.value)
            nodeToCopy = node.next
        }
    }

    private func nodesBeforeAndAfter(index: Int) -> (Node?, Node?) {
		print(">>> Entering nodesBeforeAndAfter(index=\(index))")
        assert(index >= 0)

        var i = index
        var next = head
        var prev: Node?

        while next != nil && i > 0 {
            i -= 1
            prev = next
			print("nodesBeforeAndAfter(index=\(index)): prev → \(prev)")
            next = next!.next
        }
        assert(i == 0)  // if > 0, then specified index was too large

		print("<<< Exiting nodesBeforeAndAfter(index=\(index))")
        return (prev, next)
    }

    public func insert(_ value: T, atIndex index: Int) {
		print(">>> Entering insert(value=\(value),index=\(index))")
        let newNode = Node(value: value)
        self.insert(newNode, atIndex: index)
		print("insert(value=\(value),index=\(index)): newNode → \(newNode)")
		print("<<< Exiting insert(value=\(value),index=\(index))")
    }

    public func insert(_ node: Node, atIndex index: Int) {
		print(">>> Entering insert(node=\(node),index=\(index))")
		print("insert(node=\(node),index=\(index)): newNode → \(newNode)")
		print("insert(node=\(node),index=\(index)): newNode.previous → \(newNode.previous)")
		print("insert(node=\(node),index=\(index)): newNode.next → \(newNode.next)")
        let (prev, next) = nodesBeforeAndAfter(index: index)
        let newNode = LinkedListNode(value: node.value)
        newNode.previous = prev
        newNode.next = next
        prev?.next = newNode
        next?.previous = newNode

        if prev == nil {
            head = newNode
			print("insert(node=\(node),index=\(index)): head → \(head)")
        }
    }

    public func insert(_ list: LinkedList, atIndex index: Int) {
		print(">>> Entering insert(list=\(list),index=\(index))")
        if list.isEmpty { return }
        var (prev, next) = nodesBeforeAndAfter(index: index)
        var nodeToCopy = list.head
		print("<<< Exiting insert(node=\(node),index=\(index))")
        var newNode: Node?
        while let node = nodeToCopy {
            newNode = Node(value: node.value)
            newNode?.previous = prev
			print("insert(list=\(list),index=\(index)): newNode → \(newNode)")
            if let previous = prev {
                previous.next = newNode
            } else {
                self.head = newNode
				print("insert(list=\(list),index=\(index)): self.head → \(self.head)")
            }
            nodeToCopy = nodeToCopy?.next
            prev = newNode
			print("insert(list=\(list),index=\(index)): prev → \(prev)")
        }
        prev?.next = next
        next?.previous = prev
		print("<<< Exiting insert(list=\(list),index=\(index))")
    }

    public func removeAll() {
		print(">>> Entering removeAll()")
		print("removeAll(): head → \(head)")
        head = nil
    }

    @discardableResult public func remove(node: Node) -> T {
		print(">>> Entering remove(node=\(node))")
        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
			print("remove(node=\(node)): head → \(head)")
        }
        next?.previous = prev

		print("<<< Exiting remove(node=\(node))")
		print("remove(node=\(node)): node.previous → \(node.previous)")
		print("remove(node=\(node)): node.next → \(node.next)")
        node.previous = nil
        node.next = nil
        return node.value
		print(">>> Entering remove(index=\(index))")
		print("remove(index=\(index)): node → \(node)")
		print("<<< Exiting remove(index=\(index))")
    }

    @discardableResult public func removeLast() -> T {
		print(">>> Entering removeLast()")
        assert(!isEmpty)
		print("<<< Exiting removeLast()")
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
		print(">>> Entering reverse()")
        var node = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
			print("reverse(): head → \(head)")
        }
		print("<<< Exiting reverse()")
    }
}

extension LinkedList {
    public func map<U>(transform: (T) -> U) -> LinkedList<U> {
		print(">>> Entering map(transform=\(transform))")
        let result = LinkedList<U>()
        var node = head
		print("map(transform=\(transform)): result → \(result)")
        while node != nil {
            result.append(transform(node!.value))
            node = node!.next
        }
		print("<<< Exiting map(transform=\(transform))")
        return result
    }

    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
		print(">>> Entering filter(predicate=\(predicate))")
		print("filter(predicate=\(predicate)): result → \(result)")
        let result = LinkedList<T>()
        var node = head
        while node != nil {
            if predicate(node!.value) {
                result.append(node!.value)
            }
            node = node!.next
        }
		print("<<< Exiting filter(predicate=\(predicate))")
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
