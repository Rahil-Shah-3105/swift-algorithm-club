import Foundation
// The MIT License (MIT)

// Copyright (c) 2016 Mike Taghavi (mitghi[at]me.com)

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

public class TreeNode<Key: Comparable, Payload> {
  public typealias Node = TreeNode<Key, Payload>
  
  var payload: Payload?   // Value held by the node
  
  fileprivate var key: Key    // Node's name
  internal var leftChild: Node?
  internal var rightChild: Node?
  fileprivate var height: Int
  weak fileprivate var parent: Node?
  
  public init(key: Key, payload: Payload?, leftChild: Node?, rightChild: Node?, parent: Node?, height: Int) {
    self.key = key
    self.payload = payload
    self.leftChild = leftChild
    self.rightChild = rightChild
    self.parent = parent
    self.height = height
    
    self.leftChild?.parent = self
    self.rightChild?.parent = self
  }
  
  public convenience init(key: Key, payload: Payload?) {
    self.init(key: key, payload: payload, leftChild: nil, rightChild: nil, parent: nil, height: 1)
  }
  
  public convenience init(key: Key) {
    self.init(key: key, payload: nil)
  }
  
  var isRoot: Bool {
    return parent == nil
  }
  
  var isLeaf: Bool {
    return rightChild == nil && leftChild == nil
  }
  
  var isLeftChild: Bool {
    return parent?.leftChild === self
  }
  
  var isRightChild: Bool {
    return parent?.rightChild === self
  }
  
  var hasLeftChild: Bool {
    return leftChild != nil
  }
  
  var hasRightChild: Bool {
    return rightChild != nil
  }
  
  var hasAnyChild: Bool {
    return leftChild != nil || rightChild != nil
  }
  
  var hasBothChildren: Bool {
    return leftChild != nil && rightChild != nil
  }
}

// MARK: - The AVL tree

open class AVLTree<Key: Comparable, Payload> {
  public typealias Node = TreeNode<Key, Payload>
  
  fileprivate(set) var root: Node?
  fileprivate(set) var size = 0
  
  public init() { }
}

// MARK: - Searching

extension TreeNode {
  public func minimum() -> TreeNode? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering minimum()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting minimum()\n".utf8))
    return leftChild?.minimum() ?? self
  }
  
  public func maximum() -> TreeNode? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering maximum()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting maximum()\n".utf8))
    return rightChild?.maximum() ?? self
  }
}

extension AVLTree {
  subscript(key: Key) -> Payload? {
    get { return search(input: key) }
    set { insert(key: key, payload: newValue) }
  }
  
  public func search(input: Key) -> Payload? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering search(input=\(input))\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting search(input=\(input))\n".utf8))
    return search(key: input, node: root)?.payload
  }
  
  fileprivate func search(key: Key, node: Node?) -> Node? {
    if let node = node {
      if key == node.key {
        return node
      } else if key < node.key {
        return search(key: key, node: node.leftChild)
      } else {
        return search(key: key, node: node.rightChild)
      }
    }
    return nil
  }
}

// MARK: - Inserting new items

extension AVLTree {
  public func insert(key: Key, payload: Payload? = nil) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(key=\(key),payload=\(payload))\n".utf8))
    if let root = root {
      insert(input: key, payload: payload, node: root)
    } else {
      root = Node(key: key, payload: payload)
    }
    size += 1
  }
  
  private func insert(input: Key, payload: Payload?, node: Node) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(input=\(input),payload=\(payload),node=\(node))\n".utf8))
    if input < node.key {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(key=\(key),payload=\(payload))\n".utf8))
      if let child = node.leftChild {
        insert(input: input, payload: payload, node: child)
      } else {
        let child = Node(key: input, payload: payload, leftChild: nil, rightChild: nil, parent: node, height: 1)
        node.leftChild = child
		FileHandle.standardError.write(Data("[DEBUG] insert(input=\(input),payload=\(payload),node=\(node)): node.leftChild → \(node.leftChild)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] insert(input=\(input),payload=\(payload),node=\(node)): child → \(child)\n".utf8))
        balance(node: child)
      }
    } else if input != node.key {
      if let child = node.rightChild {
        insert(input: input, payload: payload, node: child)
      } else {
        let child = Node(key: input, payload: payload, leftChild: nil, rightChild: nil, parent: node, height: 1)
        node.rightChild = child
		FileHandle.standardError.write(Data("[DEBUG] insert(input=\(input),payload=\(payload),node=\(node)): node.rightChild → \(node.rightChild)\n".utf8))
        balance(node: child)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(input=\(input),payload=\(payload),node=\(node))\n".utf8))
  }
}

// MARK: - Balancing tree

extension AVLTree {
  fileprivate func updateHeightUpwards(node: Node?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering updateHeightUpwards(node=\(node))\n".utf8))
    if let node = node {
      let lHeight = node.leftChild?.height ?? 0
      let rHeight = node.rightChild?.height ?? 0
      node.height = max(lHeight, rHeight) + 1
      updateHeightUpwards(node: node.parent)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting updateHeightUpwards(node=\(node))\n".utf8))
  }
  
  fileprivate func lrDifference(node: Node?) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering lrDifference(node=\(node))\n".utf8))
    let lHeight = node?.leftChild?.height ?? 0
    let rHeight = node?.rightChild?.height ?? 0
	FileHandle.standardError.write(Data("[WARN] <<< Exiting lrDifference(node=\(node))\n".utf8))
    return lHeight - rHeight
  }
  
  fileprivate func balance(node: Node?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering balance(node=\(node))\n".utf8))
    guard let node = node else {
      return
    }
    
    updateHeightUpwards(node: node.leftChild)
    updateHeightUpwards(node: node.rightChild)
    
    var nodes = [Node?](repeating: nil, count: 3)
    var subtrees = [Node?](repeating: nil, count: 4)
    let nodeParent = node.parent
	FileHandle.standardError.write(Data("[ERROR] balance(node=\(node)): nodes → \(nodes)\n".utf8))
    
    let lrFactor = lrDifference(node: node)
    if lrFactor > 1 {
	FileHandle.standardError.write(Data("[ERROR] balance(node=\(node)): lrFactor → \(lrFactor)\n".utf8))
      // left-left or left-right
      if lrDifference(node: node.leftChild) > 0 {
        // left-left
        nodes[0] = node
        nodes[2] = node.leftChild
        nodes[1] = nodes[2]?.leftChild
        
        subtrees[0] = nodes[1]?.leftChild
        subtrees[1] = nodes[1]?.rightChild
        subtrees[2] = nodes[2]?.rightChild
        subtrees[3] = nodes[0]?.rightChild
      } else {
        // left-right
        nodes[0] = node
        nodes[1] = node.leftChild
        nodes[2] = nodes[1]?.rightChild
        
        subtrees[0] = nodes[1]?.leftChild
        subtrees[1] = nodes[2]?.leftChild
        subtrees[2] = nodes[2]?.rightChild
        subtrees[3] = nodes[0]?.rightChild
      }
    } else if lrFactor < -1 {
      // right-left or right-right
      if lrDifference(node: node.rightChild) < 0 {
        // right-right
        nodes[1] = node
        nodes[2] = node.rightChild
        nodes[0] = nodes[2]?.rightChild
        
        subtrees[0] = nodes[1]?.leftChild
        subtrees[1] = nodes[2]?.leftChild
        subtrees[2] = nodes[0]?.leftChild
        subtrees[3] = nodes[0]?.rightChild
      } else {
        // right-left
        nodes[1] = node
        nodes[0] = node.rightChild
        nodes[2] = nodes[0]?.leftChild
        
        subtrees[0] = nodes[1]?.leftChild
        subtrees[1] = nodes[2]?.leftChild
        subtrees[2] = nodes[2]?.rightChild
        subtrees[3] = nodes[0]?.rightChild
      }
    } else {
      // Don't need to balance 'node', go for parent
      balance(node: node.parent)
      return
    }
    
    // nodes[2] is always the head
    
    if node.isRoot {
      root = nodes[2]
	FileHandle.standardError.write(Data("[WARN] balance(node=\(node)): root → \(root)\n".utf8))
      root?.parent = nil
    } else if node.isLeftChild {
      nodeParent?.leftChild = nodes[2]
      nodes[2]?.parent = nodeParent
    } else if node.isRightChild {
      nodeParent?.rightChild = nodes[2]
      nodes[2]?.parent = nodeParent
    }
    
    nodes[2]?.leftChild = nodes[1]
    nodes[1]?.parent = nodes[2]
    nodes[2]?.rightChild = nodes[0]
    nodes[0]?.parent = nodes[2]
    
    nodes[1]?.leftChild = subtrees[0]
    subtrees[0]?.parent = nodes[1]
    nodes[1]?.rightChild = subtrees[1]
    subtrees[1]?.parent = nodes[1]
    
    nodes[0]?.leftChild = subtrees[2]
    subtrees[2]?.parent = nodes[0]
    nodes[0]?.rightChild = subtrees[3]
    subtrees[3]?.parent = nodes[0]
    
    updateHeightUpwards(node: nodes[1])    // Update height from left
    updateHeightUpwards(node: nodes[0])    // Update height from right
    
	FileHandle.standardError.write(Data("[WARN] <<< Exiting balance(node=\(node))\n".utf8))
    balance(node: nodes[2]?.parent)
  }
}

// MARK: - Displaying tree

extension AVLTree {
  fileprivate func display(node: Node?, level: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering display(node=\(node),level=\(level))\n".utf8))
    if let node = node {
      display(node: node.rightChild, level: level + 1)
      print("")
      if node.isRoot {
        print("Root -> ", terminator: "")
      }
      for _ in 0..<level {
        print("        ", terminator:  "")
      }
      print("(\(node.key):\(node.height))", terminator: "")
      display(node: node.leftChild, level: level + 1)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting display(node=\(node),level=\(level))\n".utf8))
  }
  
  public func display(node: Node) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering display(node=\(node))\n".utf8))
    display(node: node, level: 0)
    print("")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting display(node=\(node))\n".utf8))
  }
  
  public func inorder(node: Node?) -> String {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering inorder(node=\(node))\n".utf8))
    var output = ""
    if let node = node {
      output = "\(inorder(node: node.leftChild)) \(print("\(node.key) ")) \(inorder(node: node.rightChild))"
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting inorder(node=\(node))\n".utf8))
    return output
  }
  
  public func preorder(node: Node?) -> String {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering preorder(node=\(node))\n".utf8))
    var output = ""
    if let node = node {
      output = "\(preorder(node: node.leftChild)) \(print("\(node.key) ")) \(preorder(node: node.rightChild))"
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting preorder(node=\(node))\n".utf8))
    return output
  }
  
  public func postorder(node: Node?) -> String {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering postorder(node=\(node))\n".utf8))
    var output = ""
    if let node = node {
      output = "\(postorder(node: node.leftChild)) \(print("\(node.key) ")) \(postorder(node: node.rightChild))"
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting postorder(node=\(node))\n".utf8))
    return output
  }
}

// MARK: - Delete node

extension AVLTree {
  public func delete(key: Key) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering delete(key=\(key))\n".utf8))
    if size == 1 {
      root = nil
	FileHandle.standardError.write(Data("[WARN] delete(key=\(key)): root → \(root)\n".utf8))
      size -= 1
    } else if let node = search(key: key, node: root) {
	FileHandle.standardError.write(Data("[ERROR] delete(key=\(key)): node → \(node)\n".utf8))
      delete(node: node)
      size -= 1
    }
  }
  
  private func delete(node: Node) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering delete(node=\(node))\n".utf8))
    if node.isLeaf {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting delete(key=\(key))\n".utf8))
      // Just remove and balance up
      if let parent = node.parent {
        guard node.isLeftChild || node.isRightChild else {
          // just in case
          fatalError("Error: tree is invalid.")
        }
        
        if node.isLeftChild {
          parent.leftChild = nil
        } else if node.isRightChild {
          parent.rightChild = nil
		FileHandle.standardError.write(Data("[DEBUG] delete(node=\(node)): parent.rightChild → \(parent.rightChild)\n".utf8))
        }
        
        balance(node: parent)
      } else {
        // at root
        root = nil
		FileHandle.standardError.write(Data("[WARN] delete(node=\(node)): root → \(root)\n".utf8))
      }
    } else {
      // Handle stem cases
      if let replacement = node.leftChild?.maximum(), replacement !== node {
        node.key = replacement.key
		FileHandle.standardError.write(Data("[DEBUG] delete(node=\(node)): node.key → \(node.key)\n".utf8))
        node.payload = replacement.payload
		FileHandle.standardError.write(Data("[DEBUG] delete(node=\(node)): node.payload → \(node.payload)\n".utf8))
        delete(node: replacement)
      } else if let replacement = node.rightChild?.minimum(), replacement !== node {
		FileHandle.standardError.write(Data("[ERROR] delete(node=\(node)): replacement → \(replacement)\n".utf8))
        node.key = replacement.key
        node.payload = replacement.payload
        delete(node: replacement)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting delete(node=\(node))\n".utf8))
  }
}

// MARK: - Advanced Stuff

extension AVLTree {
  public func doInOrder(node: Node?, _ completion: (Node) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering doInOrder(node=\(node),completion=\(completion))\n".utf8))
    if let node = node {
      doInOrder(node: node.leftChild) { lnode in
        completion(lnode)
      }
      completion(node)
      doInOrder(node: node.rightChild) { rnode in
        completion(rnode)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting doInOrder(node=\(node),completion=\(completion))\n".utf8))
  }
  
  public func doInPreOrder(node: Node?, _ completion: (Node) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering doInPreOrder(node=\(node),completion=\(completion))\n".utf8))
    if let node = node {
      completion(node)
      doInPreOrder(node: node.leftChild) { lnode in
        completion(lnode)
      }
      doInPreOrder(node: node.rightChild) { rnode in
        completion(rnode)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting doInPreOrder(node=\(node),completion=\(completion))\n".utf8))
  }
  
  public func doInPostOrder(node: Node?, _ completion: (Node) -> Void) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering doInPostOrder(node=\(node),completion=\(completion))\n".utf8))
    if let node = node {
      doInPostOrder(node: node.leftChild) { lnode in
        completion(lnode)
      }
      doInPostOrder(node: node.rightChild) { rnode in
        completion(rnode)
      }
      completion(node)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting doInPostOrder(node=\(node),completion=\(completion))\n".utf8))
  }
}

// MARK: - Debugging

extension TreeNode: CustomDebugStringConvertible {
  public var debugDescription: String {
    var s = "key: \(key), payload: \(payload), height: \(height)"
    if let parent = parent {
      s += ", parent: \(parent.key)"
    }
    if let left = leftChild {
      s += ", left = [" + left.debugDescription + "]"
    }
    if let right = rightChild {
      s += ", right = [" + right.debugDescription + "]"
    }
    return s
  }
}

extension AVLTree: CustomDebugStringConvertible {
  public var debugDescription: String {
    return root?.debugDescription ?? "[]"
  }
}

extension TreeNode: CustomStringConvertible {
  public var description: String {
    var s = ""
    if let left = leftChild {
      s += "(\(left.description)) <- "
    }
    s += "\(key)"
    if let right = rightChild {
      s += " -> (\(right.description))"
    }
    return s
  }
}

extension AVLTree: CustomStringConvertible {
  public var description: String {
    return root?.description ?? "[]"
  }
}
