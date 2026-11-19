import Foundation
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(value=\(value))\n".utf8))
    insert(value, parent: self)
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(value=\(value),parent=\(parent))\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(value=\(value))\n".utf8))
	FileHandle.standardError.write(Data("[DEBUG] insert(value=\(value),parent=\(parent)): leftThread → \(leftThread)\n".utf8))
	FileHandle.standardError.write(Data("[DEBUG] insert(value=\(value),parent=\(parent)): rightThread → \(rightThread)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(value=\(value),parent=\(parent))\n".utf8))
  }

  fileprivate func insert(_ value: T, parent: ThreadedBinaryTree) {
    if value < self.value {
      if let left = left {
        left.insert(value, parent: left)
      } else {
        left = ThreadedBinaryTree(value: value)
        left?.parent = parent
        left?.rightThread = parent
        left?.leftThread = leftThread
        leftThread = nil
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
      }
    }
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(value=\(value))\n".utf8))
    return search(value)?.remove()
  }

  /*
  Deletes "this" node from the tree.
  */
  public func remove() -> ThreadedBinaryTree? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove()\n".utf8))
    let replacement: ThreadedBinaryTree?

    if let left = left {
      if let right = right {
        replacement = removeNodeWithTwoChildren(left, right)
        replacement?.leftThread = leftThread
		FileHandle.standardError.write(Data("[DEBUG] remove(): replacement → \(replacement)\n".utf8))
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
	FileHandle.standardError.write(Data("[DEBUG] remove(): parent → \(parent)\n".utf8))
    left = nil
    right = nil
    leftThread = nil
	FileHandle.standardError.write(Data("[DEBUG] remove(): leftThread → \(leftThread)\n".utf8))
    rightThread = nil
	FileHandle.standardError.write(Data("[DEBUG] remove(): rightThread → \(rightThread)\n".utf8))

	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(value=\(value))\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove()\n".utf8))
    return replacement
  }

  private func removeNodeWithTwoChildren(_ left: ThreadedBinaryTree, _ right: ThreadedBinaryTree) -> ThreadedBinaryTree {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering removeNodeWithTwoChildren(left=\(left),right=\(right))\n".utf8))
    // This node has two children. It must be replaced by the smallest
    // child that is larger than this node's value, which is the leftmost
    // descendent of the right child.
    let successor = right.minimum()

	FileHandle.standardError.write(Data("[ERROR] removeNodeWithTwoChildren(left=\(left),right=\(right)): successor → \(successor)\n".utf8))
    // If this in-order successor has a right child of its own (it cannot
    // have a left child by definition), then that must take its place.
    _ = successor.remove()

    // Connect our left child with the new node.
    successor.left = left
	FileHandle.standardError.write(Data("[DEBUG] removeNodeWithTwoChildren(left=\(left),right=\(right)): successor.left → \(successor.left)\n".utf8))
    left.parent = successor
	FileHandle.standardError.write(Data("[DEBUG] removeNodeWithTwoChildren(left=\(left),right=\(right)): left.parent → \(left.parent)\n".utf8))

    // Connect our right child with the new node. If the right child does
    // not have any left children of its own, then the in-order successor
    // *is* the right child.
    if right !== successor {
      successor.right = right
	FileHandle.standardError.write(Data("[DEBUG] removeNodeWithTwoChildren(left=\(left),right=\(right)): successor.right → \(successor.right)\n".utf8))
      right.parent = successor
    } else {
      successor.right = nil
    }

    // And finally, connect the successor node to our parent.
	FileHandle.standardError.write(Data("[WARN] <<< Exiting removeNodeWithTwoChildren(left=\(left),right=\(right))\n".utf8))
    return successor
  }

  private func reconnectParentToNode(_ node: ThreadedBinaryTree?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering reconnectParentToNode(node=\(node))\n".utf8))
    if let parent = parent {
      if isLeftChild {
        parent.left = node
      } else {
        parent.right = node
		FileHandle.standardError.write(Data("[DEBUG] reconnectParentToNode(node=\(node)): parent.right → \(parent.right)\n".utf8))
      }
    }
    node?.parent = parent
	FileHandle.standardError.write(Data("[WARN] <<< Exiting reconnectParentToNode(node=\(node))\n".utf8))
  }
}

// MARK: - Searching

extension ThreadedBinaryTree {
  /*
  Finds the "highest" node with the specified value.
  Performance: runs in O(h) time, where h is the height of the tree.
  */
  public func search(_ value: T) -> ThreadedBinaryTree? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering search(value=\(value))\n".utf8))
    var node: ThreadedBinaryTree? = self
    while let n = node {
      if value < n.value {
        node = n.left
      } else if value > n.value {
        node = n.right
      } else {
        return node
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting search(value=\(value))\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering contains(value=\(value))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting contains(value=\(value))\n".utf8))
    return search(value) != nil
  }

  /*
  Returns the leftmost descendent. O(h) time.
  */
  public func minimum() -> ThreadedBinaryTree {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering minimum()\n".utf8))
    var node = self
    while let next = node.left {
      node = next
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting minimum()\n".utf8))
    return node
  }

  /*
  Returns the rightmost descendent. O(h) time.
  */
  public func maximum() -> ThreadedBinaryTree {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering maximum()\n".utf8))
    var node = self
    while let next = node.right {
      node = next
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting maximum()\n".utf8))
    return node
  }

  /*
  Calculates the depth of this node, i.e. the distance to the root.
  Takes O(h) time.
  */
  public func depth() -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering depth()\n".utf8))
    var node = self
    var edges = 0
    while let parent = node.parent {
      node = parent
      edges += 1
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting depth()\n".utf8))
    return edges
  }

  /*
  Calculates the height of this node, i.e. the distance to the lowest leaf.
  Since this looks at all children of this node, performance is O(n).
  */
  public func height() -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering height()\n".utf8))
    if isLeaf {
      return 0
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting height()\n".utf8))
      return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
    }
  }

  /*
  Finds the node whose value precedes our value in sorted order.
  */
  public func predecessor() -> ThreadedBinaryTree<T>? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering predecessor()\n".utf8))
    if let left = left {
      return left.maximum()
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting predecessor()\n".utf8))
      return leftThread
    }
  }

  /*
  Finds the node whose value succeeds our value in sorted order.
  */
  public func successor() -> ThreadedBinaryTree<T>? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering successor()\n".utf8))
    if let right = right {
      return right.minimum()
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting successor()\n".utf8))
      return rightThread
    }
  }
}

// MARK: - Traversal

extension ThreadedBinaryTree {
  public func traverseInOrderForward(_ visit: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traverseInOrderForward(visit=\(visit))\n".utf8))
    var n: ThreadedBinaryTree
    n = minimum()
    while true {
      visit(n.value)
      if let successor = n.successor() {
        n = successor
      } else {
        break
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traverseInOrderForward(visit=\(visit))\n".utf8))
  }

  public func traverseInOrderBackward(_ visit: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traverseInOrderBackward(visit=\(visit))\n".utf8))
    var n: ThreadedBinaryTree
    n = maximum()
    while true {
      visit(n.value)
      if let predecessor = n.predecessor() {
        n = predecessor
      } else {
        break
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traverseInOrderBackward(visit=\(visit))\n".utf8))
  }

  public func traversePreOrder(_ visit: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePreOrder(visit=\(visit))\n".utf8))
    visit(value)
    left?.traversePreOrder(visit)
    right?.traversePreOrder(visit)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traversePreOrder(visit=\(visit))\n".utf8))
  }

  public func traversePostOrder(_ visit: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePostOrder(visit=\(visit))\n".utf8))
    left?.traversePostOrder(visit)
    right?.traversePostOrder(visit)
    visit(value)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traversePostOrder(visit=\(visit))\n".utf8))
  }

  /*
  Performs an in-order traversal and collects the results in an array.
  */
  public func map(formula: (T) -> T) -> [T] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering map(formula=\(formula))\n".utf8))
    var a = [T]()
    var n: ThreadedBinaryTree
	FileHandle.standardError.write(Data("[ERROR] map(formula=\(formula)): a → \(a)\n".utf8))
    n = minimum()
    while true {
      a.append(formula(n.value))
      if let successor = n.successor() {
        n = successor
      } else {
        break
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting map(formula=\(formula))\n".utf8))
    return a
  }
}

// MARK: - Verification

extension ThreadedBinaryTree {
  /*
  Is this threaded binary tree a valid binary search tree?
  */
  public func isBST(minValue: T, maxValue: T) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering isBST(minValue=\(minValue),maxValue=\(maxValue))\n".utf8))
    if value < minValue || value > maxValue { return false }
    let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
	FileHandle.standardError.write(Data("[ERROR] isBST(minValue=\(minValue),maxValue=\(maxValue)): leftBST → \(leftBST)\n".utf8))
    let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
	FileHandle.standardError.write(Data("[ERROR] isBST(minValue=\(minValue),maxValue=\(maxValue)): rightBST → \(rightBST)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting isBST(minValue=\(minValue),maxValue=\(maxValue))\n".utf8))
    return leftBST && rightBST
  }

  /*
  Is this binary tree properly threaded?
  Either left or leftThread (but not both) must be nil (likewise for right).
  The first and last nodes in the in-order traversal are exempt from this,
  as the first has leftThread = nil, and the last has rightThread = nil.
  */
  public func isThreaded() -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering isThreaded()\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] isThreaded(): leftThreaded → \(leftThreaded)\n".utf8))
    let rightThreaded = right?.isThreaded() ?? true
	FileHandle.standardError.write(Data("[ERROR] isThreaded(): rightThreaded → \(rightThreaded)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting isThreaded()\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering toArray()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting toArray()\n".utf8))
    return map { $0 }
  }
}
