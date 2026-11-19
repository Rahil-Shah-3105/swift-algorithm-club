import Foundation
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(value=\(value))\n".utf8))
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
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(value=\(value))\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove()\n".utf8))
    let replacement: BinarySearchTree?

    // Replacement for current node can be either biggest one on the left or
    // smallest one on the right, whichever is not nil
    if let right = right {
      replacement = right.minimum()
    } else if let left = left {
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
	FileHandle.standardError.write(Data("[DEBUG] remove(): parent → \(parent)\n".utf8))
    left = nil
    right = nil

	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove()\n".utf8))
    return replacement
  }

  private func reconnectParentTo(node: BinarySearchTree?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering reconnectParentTo(node=\(node))\n".utf8))
    if let parent = parent {
      if isLeftChild {
        parent.left = node
      } else {
        parent.right = node
		FileHandle.standardError.write(Data("[DEBUG] reconnectParentTo(node=\(node)): parent.right → \(parent.right)\n".utf8))
      }
    }
    node?.parent = parent
	FileHandle.standardError.write(Data("[WARN] <<< Exiting reconnectParentTo(node=\(node))\n".utf8))
  }
}

// MARK: - Searching

extension BinarySearchTree {
  /*
    Finds the "highest" node with the specified value.
    Performance: runs in O(h) time, where h is the height of the tree.
  */
  public func search(value: T) -> BinarySearchTree? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering search(value=\(value))\n".utf8))
    var node: BinarySearchTree? = self
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering contains(value=\(value))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting contains(value=\(value))\n".utf8))
    return search(value: value) != nil
  }

  /*
    Returns the leftmost descendent. O(h) time.
  */
  public func minimum() -> BinarySearchTree {
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
  public func maximum() -> BinarySearchTree {
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
  public func predecessor() -> BinarySearchTree? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering predecessor()\n".utf8))
    if let left = left {
      return left.maximum()
    } else {
      var node = self
      while let parent = node.parent {
        if parent.value < value { return parent }
        node = parent
      }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting predecessor()\n".utf8))
      return nil
    }
  }

  /*
    Finds the node whose value succeeds our value in sorted order.
  */
  public func successor() -> BinarySearchTree? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering successor()\n".utf8))
    if let right = right {
      return right.minimum()
    } else {
      var node = self
      while let parent = node.parent {
        if parent.value > value { return parent }
        node = parent
      }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting successor()\n".utf8))
      return nil
    }
  }
}

// MARK: - Traversal

extension BinarySearchTree {
  public func traverseInOrder(process: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traverseInOrder(process=\(process))\n".utf8))
    left?.traverseInOrder(process: process)
    process(value)
    right?.traverseInOrder(process: process)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traverseInOrder(process=\(process))\n".utf8))
  }

  public func traversePreOrder(process: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePreOrder(process=\(process))\n".utf8))
    process(value)
    left?.traversePreOrder(process: process)
    right?.traversePreOrder(process: process)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traversePreOrder(process=\(process))\n".utf8))
  }

  public func traversePostOrder(process: (T) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePostOrder(process=\(process))\n".utf8))
    left?.traversePostOrder(process: process)
    right?.traversePostOrder(process: process)
    process(value)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting traversePostOrder(process=\(process))\n".utf8))
  }

  /*
    Performs an in-order traversal and collects the results in an array.
  */
  public func map(formula: (T) -> T) -> [T] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering map(formula=\(formula))\n".utf8))
    var a = [T]()
    if let left = left { a += left.map(formula: formula) }
	FileHandle.standardError.write(Data("[ERROR] map(formula=\(formula)): left → \(left)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] map(formula=\(formula)): a → \(a)\n".utf8))
    a.append(formula(value))
    if let right = right { a += right.map(formula: formula) }
	FileHandle.standardError.write(Data("[ERROR] map(formula=\(formula)): right → \(right)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting map(formula=\(formula))\n".utf8))
    return a
  }
}

/*
  Is this binary tree a valid binary search tree?
*/
extension BinarySearchTree {
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering toArray()\n".utf8))
      FileHandle.standardError.write(Data("[WARN] <<< Exiting toArray()\n".utf8))
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
