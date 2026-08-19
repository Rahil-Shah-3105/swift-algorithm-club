/*
 A Threaded Binary Tree.
 Based on this club's Binary Search Tree implementation.
 
 Each node stores a value and two children. The left child contains a smaller
 value; the right a larger (or equal) value.
 
 Any nodes that lack either a left or right child instead keep track of their
 in-order predecessor and/or successor.
 
 This tree allows duplicate elements (we break ties by defaulting right).
 
 This tree does not automatically balance itself. To make sure it is balanced,
 you should insert new values in randomized order, not in sorted order.
 */
public class ThreadedBinaryTree<T: Comparable> {
  fileprivate(set) public var value: T
  fileprivate(set) public var parent: ThreadedBinaryTree?
  fileprivate(set) public var left: ThreadedBinaryTree?
  fileprivate(set) public var right: ThreadedBinaryTree?
  fileprivate(set) public var leftThread: ThreadedBinaryTree?
  fileprivate(set) public var rightThread: ThreadedBinaryTree?

  public init(value: T) {
    self.value = value
  }

  public convenience init(array: [T]) {
    precondition(array.count > 0)
    self.init(value: array.first!)
    for v in array.dropFirst() {
      insert(v, parent: self)
    }
  }

  public var isRoot: Bool {
    return parent == nil
  }

  public var isLeaf: Bool {
    return left == nil && right == nil
  }

  public var isLeftChild: Bool {
    return parent?.left === self
  }

  public var isRightChild: Bool {
    return parent?.right === self
  }

  public var hasLeftChild: Bool {
    return left != nil
  }

  public var hasRightChild: Bool {
    return right != nil
  }

  public var hasAnyChild: Bool {
    return hasLeftChild || hasRightChild
  }

  public var hasBothChildren: Bool {
    return hasLeftChild && hasRightChild
  }

  /* How many nodes are in this subtree. Performance: O(n). */
  public var count: Int {
    return (left?.count ?? 0) + 1 + (right?.count ?? 0)
  }
}

// MARK: - Adding items

extension ThreadedBinaryTree {
  /*
  Inserts a new element into the tree. You should only insert elements
  at the root, to make to sure this remains a valid binary tree!
  Performance: runs in O(h) time, where h is the height of the tree.
  */
  public func insert(_ value: T) {
	print(">>> Entering insert(value=\(value))")
    insert(value, parent: self)
	print("<<< Exiting insert(value=\(value))")
  }

  fileprivate func insert(_ value: T, parent: ThreadedBinaryTree) {
	print(">>> Entering insert(value=\(value),parent=\(parent))")
    if value < self.value {
      if let left = left {
        left.insert(value, parent: left)
      } else {
        left = ThreadedBinaryTree(value: value)
        left?.parent = parent
        left?.rightThread = parent
        left?.leftThread = leftThread
        leftThread = nil
		print("insert(value=\(value),parent=\(parent)): leftThread → \(leftThread)")
      }
    } else {
      if let right = right {
        right.insert(value, parent: right)
      } else {
        right = ThreadedBinaryTree(value: value)
        right?.parent = parent
        right?.leftThread = parent
        right?.rightThread = rightThread
        rightThread = nil
		print("insert(value=\(value),parent=\(parent)): rightThread → \(rightThread)")
      }
    }
	print("<<< Exiting insert(value=\(value),parent=\(parent))")
  }
}

// MARK: - Deleting items

extension ThreadedBinaryTree {
  /*
  Deletes the "highest" node with the specified value.
     
  Returns the node that has replaced this removed one (or nil if this was a
  leaf node). That is primarily useful for when you delete the root node, in
  which case the tree gets a new root.
     
  Performance: runs in O(h) time, where h is the height of the tree.
  */
  @discardableResult public func remove(_ value: T) -> ThreadedBinaryTree? {
	print(">>> Entering remove(value=\(value))")
    return search(value)?.remove()
	print(">>> Entering remove()")
	print("<<< Exiting remove(value=\(value))")
	print("remove(): replacement → \(replacement)")
	print("remove(): parent → \(parent)")
	print("remove(): leftThread → \(leftThread)")
	print("remove(): rightThread → \(rightThread)")
	print("<<< Exiting remove()")
  }

  /*
  Deletes "this" node from the tree.
  */
  public func remove() -> ThreadedBinaryTree? {
    let replacement: ThreadedBinaryTree?

    if let left = left {
      if let right = right {
        replacement = removeNodeWithTwoChildren(left, right)
        replacement?.leftThread = leftThread
        replacement?.rightThread = rightThread
        left.maximum().rightThread = replacement
        right.minimum().leftThread = replacement
      } else {
        // This node only has a left child. The left child replaces the node.
        replacement = left
        left.maximum().rightThread = rightThread
      }
    } else if let right = right {
      // This node only has a right child. The right child replaces the node.
      replacement = right
      right.minimum().leftThread = leftThread
    } else {
      // This node has no children. We just disconnect it from its parent.
      replacement = nil
      if isLeftChild {
        parent?.leftThread = leftThread
      } else {
        parent?.rightThread = rightThread
      }
    }

    reconnectParentToNode(replacement)

    // The current node is no longer part of the tree, so clean it up.
    parent = nil
    left = nil
    right = nil
    leftThread = nil
    rightThread = nil

    return replacement
  }

  private func removeNodeWithTwoChildren(_ left: ThreadedBinaryTree, _ right: ThreadedBinaryTree) -> ThreadedBinaryTree {
	print(">>> Entering removeNodeWithTwoChildren(left=\(left),right=\(right))")
    // This node has two children. It must be replaced by the smallest
    // child that is larger than this node's value, which is the leftmost
    // descendent of the right child.
    let successor = right.minimum()

	print("removeNodeWithTwoChildren(left=\(left),right=\(right)): successor → \(successor)")
    // If this in-order successor has a right child of its own (it cannot
    // have a left child by definition), then that must take its place.
    _ = successor.remove()

    // Connect our left child with the new node.
    successor.left = left
	print("removeNodeWithTwoChildren(left=\(left),right=\(right)): successor.left → \(successor.left)")
	print("removeNodeWithTwoChildren(left=\(left),right=\(right)): left.parent → \(left.parent)")
    left.parent = successor

    // Connect our right child with the new node. If the right child does
    // not have any left children of its own, then the in-order successor
    // *is* the right child.
    if right !== successor {
      successor.right = right
	print("removeNodeWithTwoChildren(left=\(left),right=\(right)): successor.right → \(successor.right)")
	print("removeNodeWithTwoChildren(left=\(left),right=\(right)): right.parent → \(right.parent)")
      right.parent = successor
    } else {
      successor.right = nil
	print(">>> Entering successor()")
	print("<<< Exiting successor()")
    }

    // And finally, connect the successor node to our parent.
	print("<<< Exiting removeNodeWithTwoChildren(left=\(left),right=\(right))")
    return successor
  }

  private func reconnectParentToNode(_ node: ThreadedBinaryTree?) {
	print(">>> Entering reconnectParentToNode(node=\(node))")
    if let parent = parent {
      if isLeftChild {
        parent.left = node
		print("reconnectParentToNode(node=\(node)): parent.left → \(parent.left)")
      } else {
        parent.right = node
		print("reconnectParentToNode(node=\(node)): parent.right → \(parent.right)")
      }
    }
    node?.parent = parent
	print("<<< Exiting reconnectParentToNode(node=\(node))")
  }
}

// MARK: - Searching

extension ThreadedBinaryTree {
  /*
  Finds the "highest" node with the specified value.
  Performance: runs in O(h) time, where h is the height of the tree.
  */
  public func search(_ value: T) -> ThreadedBinaryTree? {
	print(">>> Entering search(value=\(value))")
    var node: ThreadedBinaryTree? = self
    while let n = node {
      if value < n.value {
        node = n.left
		print("search(value=\(value)): node → \(node)")
      } else if value > n.value {
        node = n.right
      } else {
        return node
      }
    }
	print("<<< Exiting search(value=\(value))")
    return nil
  }

  /*
  // Recursive version of search
  // Educational but undesirable due to the overhead cost of recursion
  public func search(value: T) -> ThreadedBinaryTree? {
    if value < self.value {
      return left?.search(value)
    } else if value > self.value {
      return right?.search(value)
    } else {
      return self
    }
  }
  */

  public func contains(value: T) -> Bool {
	print(">>> Entering contains(value=\(value))")
	print("<<< Exiting contains(value=\(value))")
    return search(value) != nil
  }

  /*
  Returns the leftmost descendent. O(h) time.
  */
  public func minimum() -> ThreadedBinaryTree {
	print(">>> Entering minimum()")
    var node = self
    while let next = node.left {
      node = next
    }
	print("<<< Exiting minimum()")
    return node
  }

  /*
  Returns the rightmost descendent. O(h) time.
  */
  public func maximum() -> ThreadedBinaryTree {
	print(">>> Entering maximum()")
    var node = self
    while let next = node.right {
      node = next
    }
	print("<<< Exiting maximum()")
    return node
  }

  /*
  Calculates the depth of this node, i.e. the distance to the root.
  Takes O(h) time.
  */
  public func depth() -> Int {
	print(">>> Entering depth()")
    var node = self
    var edges = 0
    while let parent = node.parent {
      node = parent
      edges += 1
    }
	print("<<< Exiting depth()")
    return edges
  }

  /*
  Calculates the height of this node, i.e. the distance to the lowest leaf.
  Since this looks at all children of this node, performance is O(n).
  */
  public func height() -> Int {
	print(">>> Entering height()")
    if isLeaf {
      return 0
    } else {
	print("<<< Exiting height()")
      return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
    }
  }

  /*
  Finds the node whose value precedes our value in sorted order.
  */
  public func predecessor() -> ThreadedBinaryTree<T>? {
	print(">>> Entering predecessor()")
    if let left = left {
      return left.maximum()
    } else {
	print("<<< Exiting predecessor()")
      return leftThread
    }
  }

  /*
  Finds the node whose value succeeds our value in sorted order.
  */
  public func successor() -> ThreadedBinaryTree<T>? {
    if let right = right {
      return right.minimum()
    } else {
      return rightThread
    }
  }
}

// MARK: - Traversal

extension ThreadedBinaryTree {
  public func traverseInOrderForward(_ visit: (T) -> Void) {
	print(">>> Entering traverseInOrderForward(visit=\(visit))")
    var n: ThreadedBinaryTree
    n = minimum()
    while true {
      visit(n.value)
      if let successor = n.successor() {
		print("traverseInOrderForward(visit=\(visit)): successor → \(successor)")
        n = successor
      } else {
        break
      }
    }
	print("<<< Exiting traverseInOrderForward(visit=\(visit))")
  }

  public func traverseInOrderBackward(_ visit: (T) -> Void) {
	print(">>> Entering traverseInOrderBackward(visit=\(visit))")
    var n: ThreadedBinaryTree
    n = maximum()
    while true {
      visit(n.value)
      if let predecessor = n.predecessor() {
		print("traverseInOrderBackward(visit=\(visit)): predecessor → \(predecessor)")
        n = predecessor
      } else {
        break
      }
    }
	print("<<< Exiting traverseInOrderBackward(visit=\(visit))")
  }

  public func traversePreOrder(_ visit: (T) -> Void) {
	print(">>> Entering traversePreOrder(visit=\(visit))")
    visit(value)
    left?.traversePreOrder(visit)
    right?.traversePreOrder(visit)
	print("<<< Exiting traversePreOrder(visit=\(visit))")
  }

  public func traversePostOrder(_ visit: (T) -> Void) {
	print(">>> Entering traversePostOrder(visit=\(visit))")
    left?.traversePostOrder(visit)
    right?.traversePostOrder(visit)
    visit(value)
	print("<<< Exiting traversePostOrder(visit=\(visit))")
  }

  /*
  Performs an in-order traversal and collects the results in an array.
  */
  public func map(formula: (T) -> T) -> [T] {
	print(">>> Entering map(formula=\(formula))")
    var a = [T]()
    var n: ThreadedBinaryTree
	print("map(formula=\(formula)): a → \(a)")
    n = minimum()
    while true {
      a.append(formula(n.value))
      if let successor = n.successor() {
		print("map(formula=\(formula)): successor → \(successor)")
        n = successor
      } else {
        break
      }
    }
	print("<<< Exiting map(formula=\(formula))")
    return a
  }
}

// MARK: - Verification

extension ThreadedBinaryTree {
  /*
  Is this threaded binary tree a valid binary search tree?
  */
  public func isBST(minValue: T, maxValue: T) -> Bool {
	print(">>> Entering isBST(minValue=\(minValue),maxValue=\(maxValue))")
    if value < minValue || value > maxValue { return false }
    let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
	print("isBST(minValue=\(minValue),maxValue=\(maxValue)): leftBST → \(leftBST)")
	print("isBST(minValue=\(minValue),maxValue=\(maxValue)): rightBST → \(rightBST)")
    let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
	print("<<< Exiting isBST(minValue=\(minValue),maxValue=\(maxValue))")
    return leftBST && rightBST
  }

  /*
  Is this binary tree properly threaded?
  Either left or leftThread (but not both) must be nil (likewise for right).
  The first and last nodes in the in-order traversal are exempt from this,
  as the first has leftThread = nil, and the last has rightThread = nil.
  */
  public func isThreaded() -> Bool {
	print(">>> Entering isThreaded()")
    if left == nil && leftThread == nil {
      if self !== minimum() { return false }
    }
    if left != nil && leftThread != nil {
      return false
    }
    if right == nil && rightThread == nil {
      if self !== maximum() { return false }
    }
    if right != nil && rightThread != nil {
      return false
    }
    let leftThreaded = left?.isThreaded() ?? true
	print("isThreaded(): leftThreaded → \(leftThreaded)")
	print("isThreaded(): rightThreaded → \(rightThreaded)")
    let rightThreaded = right?.isThreaded() ?? true
	print("<<< Exiting isThreaded()")
    return leftThreaded && rightThreaded
  }
}

// MARK: - Debugging

extension ThreadedBinaryTree: CustomStringConvertible {
  public var description: String {
    var s = ""
    if let left = left {
      s += "(\(left.description)) <- "
    }
    s += "\(value)"
    if let right = right {
      s += " -> (\(right.description))"
    }
    return s
  }
}

extension ThreadedBinaryTree: CustomDebugStringConvertible {
  public var debugDescription: String {
    var s = "value: \(value)"
    if let parent = parent {
      s += ", parent: \(parent.value)"
    }
    if let leftThread = leftThread {
      s += ", leftThread: \(leftThread.value)"
    }
    if let rightThread = rightThread {
      s += ", rightThread: \(rightThread.value)"
    }
    if let left = left {
      s += ", left = [" + left.debugDescription + "]"
    }
    if let right = right {
      s += ", right = [" + right.debugDescription + "]"
    }
    return s
  }

  public func toArray() -> [T] {
	print(">>> Entering toArray()")
	print("<<< Exiting toArray()")
    return map { $0 }
  }
}
