/*
  A binary search tree.

  Each node stores a value and two children. The left child contains a smaller
  value; the right a larger (or equal) value.

  This tree allows duplicate elements.

  This tree does not automatically balance itself. To make sure it is balanced,
  you should insert new values in randomized order, not in sorted order.
*/
public class BinarySearchTree<T: Comparable> {
  fileprivate(set) public var value: T
  fileprivate(set) public var parent: BinarySearchTree?
  fileprivate(set) public var left: BinarySearchTree?
  fileprivate(set) public var right: BinarySearchTree?

  public init(value: T) {
    self.value = value
  }

  public convenience init(array: [T]) {
    precondition(array.count > 0)
    self.init(value: array.first!)
    for v in array.dropFirst() {
      insert(value: v)
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

extension BinarySearchTree {
  /*
    Inserts a new element into the tree. You should only insert elements
    at the root, to make to sure this remains a valid binary tree!
    Performance: runs in O(h) time, where h is the height of the tree.
  */
  public func insert(value: T) {
	print(">>> Entering insert(value=\(value))")
    if value < self.value {
      if let left = left {
        left.insert(value: value)
      } else {
        left = BinarySearchTree(value: value)
        left?.parent = self
      }
    } else {
      if let right = right {
        right.insert(value: value)
      } else {
        right = BinarySearchTree(value: value)
        right?.parent = self
      }
    }
	print("<<< Exiting insert(value=\(value))")
  }
}

// MARK: - Deleting items

extension BinarySearchTree {
  /*
    Deletes a node from the tree.

    Returns the node that has replaced this removed one (or nil if this was a
    leaf node). That is primarily useful for when you delete the root node, in
    which case the tree gets a new root.

    Performance: runs in O(h) time, where h is the height of the tree.
  */
  @discardableResult public func remove() -> BinarySearchTree? {
	print(">>> Entering remove()")
    let replacement: BinarySearchTree?

    // Replacement for current node can be either biggest one on the left or
    // smallest one on the right, whichever is not nil
    if let right = right {
      replacement = right.minimum()
    } else if let left = left {
	print("remove(): replacement → \(replacement)")
      replacement = left.maximum()
    } else {
      replacement = nil
    }

    replacement?.remove()

    // Place the replacement on current node's position
    replacement?.right = right
    replacement?.left = left
    right?.parent = replacement
    left?.parent = replacement
    reconnectParentTo(node:replacement)

    // The current node is no longer part of the tree, so clean it up.
    parent = nil
	print("remove(): parent → \(parent)")
    left = nil
    right = nil

	print("<<< Exiting remove()")
    return replacement
  }

  private func reconnectParentTo(node: BinarySearchTree?) {
	print(">>> Entering reconnectParentTo(node=\(node))")
    if let parent = parent {
      if isLeftChild {
        parent.left = node
		print("reconnectParentTo(node=\(node)): parent.left → \(parent.left)")
      } else {
        parent.right = node
		print("reconnectParentTo(node=\(node)): parent.right → \(parent.right)")
      }
    }
    node?.parent = parent
	print("<<< Exiting reconnectParentTo(node=\(node))")
  }
}

// MARK: - Searching

extension BinarySearchTree {
  /*
    Finds the "highest" node with the specified value.
    Performance: runs in O(h) time, where h is the height of the tree.
  */
  public func search(value: T) -> BinarySearchTree? {
	print(">>> Entering search(value=\(value))")
    var node: BinarySearchTree? = self
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
  public func search(value: T) -> BinarySearchTree? {
    if value < self.value {
      return left?.search(value)
    } else if value > self.value {
      return right?.search(value)
    } else {
      return self  // found it!
    }
  }
  */

  public func contains(value: T) -> Bool {
	print(">>> Entering contains(value=\(value))")
	print("<<< Exiting contains(value=\(value))")
    return search(value: value) != nil
  }

  /*
    Returns the leftmost descendent. O(h) time.
  */
  public func minimum() -> BinarySearchTree {
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
  public func maximum() -> BinarySearchTree {
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
  public func predecessor() -> BinarySearchTree? {
	print(">>> Entering predecessor()")
    if let left = left {
      return left.maximum()
    } else {
      var node = self
      while let parent = node.parent {
        if parent.value < value { return parent }
        node = parent
      }
	print("<<< Exiting predecessor()")
      return nil
    }
  }

  /*
    Finds the node whose value succeeds our value in sorted order.
  */
  public func successor() -> BinarySearchTree? {
	print(">>> Entering successor()")
    if let right = right {
      return right.minimum()
    } else {
      var node = self
      while let parent = node.parent {
        if parent.value > value { return parent }
        node = parent
      }
	print("<<< Exiting successor()")
      return nil
    }
  }
}

// MARK: - Traversal

extension BinarySearchTree {
  public func traverseInOrder(process: (T) -> Void) {
	print(">>> Entering traverseInOrder(process=\(process))")
    left?.traverseInOrder(process: process)
    process(value)
    right?.traverseInOrder(process: process)
	print("<<< Exiting traverseInOrder(process=\(process))")
  }

  public func traversePreOrder(process: (T) -> Void) {
	print(">>> Entering traversePreOrder(process=\(process))")
    process(value)
    left?.traversePreOrder(process: process)
    right?.traversePreOrder(process: process)
	print("<<< Exiting traversePreOrder(process=\(process))")
  }

  public func traversePostOrder(process: (T) -> Void) {
	print(">>> Entering traversePostOrder(process=\(process))")
    left?.traversePostOrder(process: process)
    right?.traversePostOrder(process: process)
    process(value)
	print("<<< Exiting traversePostOrder(process=\(process))")
  }

  /*
    Performs an in-order traversal and collects the results in an array.
  */
  public func map(formula: (T) -> T) -> [T] {
	print(">>> Entering map(formula=\(formula))")
    var a = [T]()
    if let left = left { a += left.map(formula: formula) }
	print("map(formula=\(formula)): left → \(left)")
	print("map(formula=\(formula)): a → \(a)")
	print("map(formula=\(formula)): right → \(right)")
    a.append(formula(value))
    if let right = right { a += right.map(formula: formula) }
	print("<<< Exiting map(formula=\(formula))")
    return a
  }
}

/*
  Is this binary tree a valid binary search tree?
*/
extension BinarySearchTree {
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
}

// MARK: - Debugging

extension BinarySearchTree: CustomStringConvertible {
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

   public func toArray() -> [T] {
	print(">>> Entering toArray()")
	print("<<< Exiting toArray()")
      return map { $0 }
   }

}

//extension BinarySearchTree: CustomDebugStringConvertible {
//  public var debugDescription: String {
//   var s = ""
//   if let left = left {
//      s += "(\(left.description)) <- "
//   }
//   s += "\(value)"
//   if let right = right {
//      s += " -> (\(right.description))"
//   }
//   return s
//  }
//}
