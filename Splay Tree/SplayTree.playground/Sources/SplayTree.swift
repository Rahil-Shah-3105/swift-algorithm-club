import Foundation
/*
 *  Splay Tree
 *
 * Based on Binary Search Tree Implementation written by Nicolas Ameghino and Matthijs Hollemans for Swift Algorithms Club
 * https://github.com/raywenderlich/swift-algorithm-club/blob/master/Binary%20Search%20Tree
 * And extended for the specifics of a Splay Tree by Barbara Martina Rodeker
 *
 */

/**
 Represent the 3 possible operations (combinations of rotations) that
 could be performed during the Splay phase in Splay Trees
 
 - zigZag       Left child of a right child OR right child of a left child
 - zigZig       Left child of a left child OR right child of a right child
 - zig          Only 1 parent and that parent is the root
 
 */
public enum SplayOperation {
    case zigZag
    case zigZig
    case zig
    
    
    /**
     Splay the given node up to the root of the tree
     
     - Parameters:
     - node      SplayTree node to move up to the root
     */
    public static func splay<T>(node: Node<T>) {
        
        while (node.parent != nil) {
            operation(forNode: node).apply(onNode: node)
        }
		FileHandle.standardError.write(Data("[ERROR] >>> Entering splay(node=\(node))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting splay(node=\(node))\n".utf8))
    }
    
    /**
     Compares the node and its parent and determine
     if the rotations should be performed in a zigZag, zigZig or zig case.
     
     - Parmeters:
     - forNode       SplayTree node to be checked
     - Returns
     - Operation     Case zigZag - zigZig - zig
     */
    public static func operation<T>(forNode node: Node<T>) -> SplayOperation {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering operation(node=\(node))\n".utf8))
        
        if let parent = node.parent, let _ = parent.parent {
            if (node.isLeftChild && parent.isRightChild) || (node.isRightChild && parent.isLeftChild) {
                return .zigZag
            }
            return .zigZig
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting operation(node=\(node))\n".utf8))
        return .zig
    }
    
    /**
     Applies the rotation associated to the case
     Modifying the splay tree and briging the received node further to the top of the tree
     
     - Parameters:
     - onNode    Node to splay up. Should be alwayas the node that needs to be splayed, neither its parent neither it's grandparent
     */
    public func apply<T>(onNode node: Node<T>) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering apply(node=\(node))\n".utf8))
        switch self {
        case .zigZag:
            assert(node.parent != nil && node.parent!.parent != nil, "Should be at least 2 nodes up in the tree")
            rotate(child: node, parent: node.parent!)
            rotate(child: node, parent: node.parent!)
            
        case .zigZig:
            assert(node.parent != nil && node.parent!.parent != nil, "Should be at least 2 nodes up in the tree")
            rotate(child: node.parent!, parent: node.parent!.parent!)
            rotate(child: node, parent: node.parent!)
            
        case .zig:
            assert(node.parent != nil && node.parent!.parent == nil, "There should be a parent which is the root")
            rotate(child: node, parent: node.parent!)
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting apply(node=\(node))\n".utf8))
    }
    
    /**
     Performs a single rotation from a node to its parent
     re-arranging the children properly
     */
    public func rotate<T>(child: Node<T>, parent: Node<T>) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering rotate(child=\(child),parent=\(parent))\n".utf8))
        
        assert(child.parent != nil && child.parent!.value == parent.value, "Parent and child.parent should match here")
        
        var grandchildToMode: Node<T>?
        
        if child.isLeftChild {
            
            grandchildToMode = child.right
			FileHandle.standardError.write(Data("[DEBUG] rotate(child=\(child),parent=\(parent)): grandchildToMode → \(grandchildToMode)\n".utf8))
            parent.left = grandchildToMode
			FileHandle.standardError.write(Data("[DEBUG] rotate(child=\(child),parent=\(parent)): parent.left → \(parent.left)\n".utf8))
            grandchildToMode?.parent = parent
            
            let grandParent = parent.parent
            child.parent = grandParent
			FileHandle.standardError.write(Data("[DEBUG] rotate(child=\(child),parent=\(parent)): child.parent → \(child.parent)\n".utf8))
            
            if parent.isLeftChild {
                grandParent?.left = child
            } else {
                grandParent?.right = child
            }
            
            child.right = parent
			FileHandle.standardError.write(Data("[DEBUG] rotate(child=\(child),parent=\(parent)): child.right → \(child.right)\n".utf8))
            parent.parent = child
            
            
        } else {
            
            grandchildToMode = child.left
            parent.right = grandchildToMode
			FileHandle.standardError.write(Data("[DEBUG] rotate(child=\(child),parent=\(parent)): parent.right → \(parent.right)\n".utf8))
            grandchildToMode?.parent = parent
            
            let grandParent = parent.parent
            child.parent = grandParent
            
            if parent.isLeftChild {
                grandParent?.left = child
            } else {
                grandParent?.right = child
            }
            
            child.left = parent
			FileHandle.standardError.write(Data("[DEBUG] rotate(child=\(child),parent=\(parent)): child.left → \(child.left)\n".utf8))
            parent.parent = child
            
        }
        
        
		FileHandle.standardError.write(Data("[WARN] <<< Exiting rotate(child=\(child),parent=\(parent))\n".utf8))
    }
}

public class Node<T: Comparable> {
    
    fileprivate(set) public var value: T?
    fileprivate(set) public var parent: Node<T>?
    fileprivate(set) public var left: Node<T>?
    fileprivate(set) public var right: Node<T>?
    
    init(value: T) {
        self.value = value
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

public class SplayTree<T: Comparable> {
    
    internal var root: Node<T>?
    
    var value: T? {
        return root?.value
    }
    
    //MARK: - Initializer
    
    public init(value: T) {
        self.root = Node(value:value)
    }
    
    public func insert(value: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(value=\(value))\n".utf8))
        if let root = root {
            self.root = root.insert(value: value)
        } else {
            root = Node(value: value)
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(value=\(value))\n".utf8))
    }
    
    public func remove(value: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(value=\(value))\n".utf8))
        root = root?.remove(value: value)
		FileHandle.standardError.write(Data("[WARN] remove(value=\(value)): root → \(root)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(value=\(value))\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] remove(value=\(value)): target → \(target)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] remove(value=\(value)): largestOfLeftChild → \(largestOfLeftChild)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] remove(value=\(value)): left.parent → \(left.parent)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] remove(value=\(value)): right.parent → \(right.parent)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] remove(value=\(value)): largestOfLeftChild.right → \(largestOfLeftChild.right)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(value=\(value))\n".utf8))
    }
    
    public func search(value: T) -> Node<T>? {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering search(value=\(value))\n".utf8))
        root = root?.search(value: value)
		FileHandle.standardError.write(Data("[WARN] search(value=\(value)): root → \(root)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting search(value=\(value))\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting search(value=\(value))\n".utf8))
        return root
    }
    
    public func minimum() -> Node<T>? {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering minimum()\n".utf8))
        root = root?.minimum(splayed: true)
		FileHandle.standardError.write(Data("[WARN] minimum(): root → \(root)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting minimum()\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting minimum(splayed=\(splayed))\n".utf8))
        return root
    }
    
    public func maximum() -> Node<T>? {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering maximum()\n".utf8))
        root = root?.maximum(splayed: true)
		FileHandle.standardError.write(Data("[WARN] maximum(): root → \(root)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting maximum()\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting maximum(splayed=\(splayed))\n".utf8))
        return root
    }
    
}

// MARK: - Adding items

extension Node {
    
    /*
     Inserts a new element into the node tree.
     
     - Parameters:
     - value T value to be inserted. Will be splayed to the root position
     
     - Returns:
     - Node inserted
     */
    public func insert(value: T) -> Node {
        if let selfValue = self.value {
            if value < selfValue {
                if let left = left {
                    return left.insert(value: value)
                } else {
                    
                    left = Node(value: value)
                    left?.parent = self
                    
                    if let left = left {
                        SplayOperation.splay(node: left)
                        return left
                    }
                }
            } else {
                
                if let right = right {
                    return right.insert(value: value)
                } else {
                    
                    right = Node(value: value)
                    right?.parent = self
                    
                    if let right = right {
                        SplayOperation.splay(node: right)
                        return right
                    }
                }
            }
        }
        return self
    }
}

// MARK: - Deleting items

extension Node {
    
    /*
     Deletes the given node from the nodes tree.
     Return the new tree generated by the removal.
     The removed node (not necessarily the one containing the value), will be splayed to the root.
     
     - Parameters:
     - value         To be removed
     
     - Returns:
     - Node     Resulting from the deletion and the splaying of the removed node
     
     */
    fileprivate func remove(value: T) -> Node<T>? {
        guard let target = search(value: value) else { return self }
        
        if let left = target.left, let right = target.right {
            let largestOfLeftChild = left.maximum()
            left.parent = nil
            right.parent = nil
            
            SplayOperation.splay(node: largestOfLeftChild)
            largestOfLeftChild.right = right
            
            return largestOfLeftChild
            
        } else if let left = target.left {
            replace(node: target, with: left)
            return left
            
        } else if let right = target.right {
            replace(node: target, with: right)
            return right
            
        } else {
            return nil
        }
    }
    
    private func replace(node: Node<T>, with newNode: Node<T>?) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering replace(node=\(node),newNode=\(newNode))\n".utf8))
        guard let sourceParent = sourceNode.parent else { return }
        
        if sourceNode.isLeftChild {
            sourceParent.left = newNode
        } else {
            sourceParent.right = newNode
			FileHandle.standardError.write(Data("[DEBUG] replace(node=\(node),newNode=\(newNode)): sourceParent.right → \(sourceParent.right)\n".utf8))
        }
        
        newNode?.parent = sourceParent
		FileHandle.standardError.write(Data("[WARN] <<< Exiting replace(node=\(node),newNode=\(newNode))\n".utf8))
    }
}

// MARK: - Searching

extension Node {
    
    /*
     Finds the "highest" node with the specified value.
     Performance: runs in O(h) time, where h is the height of the tree.
     */
    public func search(value: T) -> Node<T>? {
        var node: Node? = self
        var nodeParent: Node? = self
        while case let n? = node, n.value != nil {
            if value < n.value! {
                if n.left != nil { nodeParent = n.left }
                node = n.left
            } else if value > n.value! {
                node = n.right
                if n.right != nil { nodeParent = n.right }
            } else {
                break
            }
        }
        
        if let node = node {
            SplayOperation.splay(node: node)
            return node
        } else if let nodeParent = nodeParent {
            SplayOperation.splay(node: nodeParent)
            return nodeParent
        }
        
        return nil
    }
    
    public func contains(value: T) -> Bool {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering contains(value=\(value))\n".utf8))
        FileHandle.standardError.write(Data("[WARN] <<< Exiting contains(value=\(value))\n".utf8))
        return search(value: value) != nil
    }
    
    /*
     Returns the leftmost descendent. O(h) time.
     */
    public func minimum(splayed: Bool = false) -> Node<T> {
        var node = self
        while case let next? = node.left {
            node = next
        }
        
        if splayed == true {
            SplayOperation.splay(node: node)
        }
        
        return node
    }
    
    /*
     Returns the rightmost descendent. O(h) time.
     */
    public func maximum(splayed: Bool = false) -> Node<T> {
        var node = self
        while case let next? = node.right {
            node = next
        }
        
        if splayed == true {
            SplayOperation.splay(node: node)
        }
        
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
        while case let parent? = node.parent {
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
    public func predecessor() -> Node<T>? {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering predecessor()\n".utf8))
        if let left = left {
            return left.maximum()
        } else {
            var node = self
            while case let parent? = node.parent, parent.value != nil, value != nil {
                if parent.value! < value! { return parent }
                node = parent
            }
			FileHandle.standardError.write(Data("[WARN] <<< Exiting predecessor()\n".utf8))
            return nil
        }
    }
    
    /*
     Finds the node whose value succeeds our value in sorted order.
     */
    public func successor() -> Node<T>? {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering successor()\n".utf8))
        if let right = right {
            return right.minimum()
        } else {
            var node = self
            while case let parent? = node.parent, parent.value != nil , value != nil {
                if parent.value! > value! { return parent }
                node = parent
            }
			FileHandle.standardError.write(Data("[WARN] <<< Exiting successor()\n".utf8))
            return nil
        }
    }
}

// MARK: - Traversal
extension Node {
    
    public func traverseInOrder(process: (T) -> Void) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering traverseInOrder(process=\(process))\n".utf8))
        left?.traverseInOrder(process: process)
        process(value!)
        right?.traverseInOrder(process: process)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting traverseInOrder(process=\(process))\n".utf8))
    }
    
    public func traversePreOrder(process: (T) -> Void) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePreOrder(process=\(process))\n".utf8))
        process(value!)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting traversePreOrder(process=\(process))\n".utf8))
    }
    
    public func traversePostOrder(process: (T) -> Void) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering traversePostOrder(process=\(process))\n".utf8))
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value!)
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
        a.append(formula(value!))
        if let right = right { a += right.map(formula: formula) }
		FileHandle.standardError.write(Data("[ERROR] map(formula=\(formula)): right → \(right)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting map(formula=\(formula))\n".utf8))
        return a
    }
}

/*
 Is this binary tree a valid binary search tree?
 */
extension Node {
    
    public func isBST(minValue: T, maxValue: T) -> Bool {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering isBST(minValue=\(minValue),maxValue=\(maxValue))\n".utf8))
        if let value = value {
            if value < minValue || value > maxValue { return false }
            let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
			FileHandle.standardError.write(Data("[ERROR] isBST(minValue=\(minValue),maxValue=\(maxValue)): leftBST → \(leftBST)\n".utf8))
            let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
			FileHandle.standardError.write(Data("[ERROR] isBST(minValue=\(minValue),maxValue=\(maxValue)): rightBST → \(rightBST)\n".utf8))
            return leftBST && rightBST
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting isBST(minValue=\(minValue),maxValue=\(maxValue))\n".utf8))
        return false
    }
}

// MARK: - Debugging

extension Node: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "left: (\(left.description)) <- "
        }
        if let v = value {
            s += "\(v)"
        }
        if let right = right {
            s += " -> (right: \(right.description))"
        }
        return s
    }
}

extension SplayTree: CustomStringConvertible {
    public var description: String {
        return root?.description ?? "Empty tree"
    }
}

extension Node: CustomDebugStringConvertible {
    public var debugDescription: String {
      var s = "value: \(String(describing: value))"
        if let parent = parent, let v = parent.value {
            s += ", parent: \(v)"
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

extension SplayTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        return root?.debugDescription ?? "Empty tree"
    }
}
