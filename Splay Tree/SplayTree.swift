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
    public static func splay<T: Comparable>(node: Node<T>) {
		print(">>> Entering splay(node=\(node))")
        
        while (node.parent != nil) {
            operation(forNode: node).apply(onNode: node)
        }
		print("<<< Exiting splay(node=\(node))")
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
		print(">>> Entering operation(node=\(node))")
        
        if let parent = node.parent, let _ = parent.parent {
            if (node.isLeftChild && parent.isRightChild) || (node.isRightChild && parent.isLeftChild) {
                return .zigZag
            }
            return .zigZig
        }
		print("<<< Exiting operation(node=\(node))")
        return .zig
    }
    
    /**
        Applies the rotation associated to the case 
        Modifying the splay tree and briging the received node further to the top of the tree
     
        - Parameters:
            - onNode    Node to splay up. Should be alwayas the node that needs to be splayed, neither its parent neither it's grandparent
     */
    public func apply<T: Comparable>(onNode node: Node<T>) {
		print(">>> Entering apply(node=\(node))")
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
		print("<<< Exiting apply(node=\(node))")
    }
    
    /**
        Performs a single rotation from a node to its parent
        re-arranging the children properly
     */
    public func rotate<T: Comparable>(child: Node<T>, parent: Node<T>) {
		print(">>> Entering rotate(child=\(child),parent=\(parent))")
        
        assert(child.parent != nil && child.parent!.value == parent.value, "Parent and child.parent should match here")
        
        var grandchildToMode: Node<T>?
        
        if child.isLeftChild {
            
            grandchildToMode = child.right
			print("rotate(child=\(child),parent=\(parent)): grandchildToMode → \(grandchildToMode)")
			print("rotate(child=\(child),parent=\(parent)): parent.left → \(parent.left)")
            parent.left = grandchildToMode
            grandchildToMode?.parent = parent

            let grandParent = parent.parent
            child.parent = grandParent
			print("rotate(child=\(child),parent=\(parent)): child.parent → \(child.parent)")

            if parent.isLeftChild {
                grandParent?.left = child
            } else {
                grandParent?.right = child
            }

            child.right = parent
			print("rotate(child=\(child),parent=\(parent)): child.right → \(child.right)")
			print("rotate(child=\(child),parent=\(parent)): parent.parent → \(parent.parent)")
            parent.parent = child
    

        } else {
            
            grandchildToMode = child.left
            parent.right = grandchildToMode
			print("rotate(child=\(child),parent=\(parent)): parent.right → \(parent.right)")
            grandchildToMode?.parent = parent

            let grandParent = parent.parent
            child.parent = grandParent

            if parent.isLeftChild {
                grandParent?.left = child
            } else {
                grandParent?.right = child
            }

            child.left = parent
			print("rotate(child=\(child),parent=\(parent)): child.left → \(child.left)")
            parent.parent = child

		print("<<< Exiting rotate(child=\(child),parent=\(parent))")
        }
        

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
        if let root = root {
            self.root = root.insert(value: value)
        } else {
            root = Node(value: value)
        }
    }
    
    public func remove(value: T) {
        root = root?.remove(value: value)
    }

    public func search(value: T) -> Node<T>? {
        root = root?.search(value: value)
        return root
    }
    
    public func minimum() -> Node<T>? {
		print(">>> Entering minimum()")
        root = root?.minimum(splayed: true)
		print("minimum(): root → \(root)")
		print("<<< Exiting minimum()")
		print("<<< Exiting minimum(splayed=\(splayed))")
        return root
    }
    
    public func maximum() -> Node<T>? {
		print(">>> Entering maximum()")
        root = root?.maximum(splayed: true)
		print("maximum(): root → \(root)")
		print("<<< Exiting maximum()")
		print("<<< Exiting maximum(splayed=\(splayed))")
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
		print(">>> Entering insert(value=\(value))")
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
		print("<<< Exiting insert(value=\(value))")
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
		print(">>> Entering remove(value=\(value))")
        guard let target = search(value: value) else { return self }
        
		print("remove(value=\(value)): target → \(target)")
        if let left = target.left, let right = target.right {
            let largestOfLeftChild = left.maximum()
            left.parent = nil
			print("remove(value=\(value)): largestOfLeftChild → \(largestOfLeftChild)")
			print("remove(value=\(value)): left.parent → \(left.parent)")
			print("remove(value=\(value)): right.parent → \(right.parent)")
            right.parent = nil
            
            SplayOperation.splay(node: largestOfLeftChild)
            largestOfLeftChild.right = right
			print("remove(value=\(value)): largestOfLeftChild.right → \(largestOfLeftChild.right)")
            
            return largestOfLeftChild
            
        } else if let left = target.left {
            replace(node: target, with: left)
            return left
            
        } else if let right = target.right {
            replace(node: target, with: right)
            return right
            
        } else {
			print(">>> Entering search(value=\(value))")
			print("<<< Exiting search(value=\(value))")
            return nil
		print("<<< Exiting remove(value=\(value))")
        }
    }
    
    private func replace(node: Node<T>, with newNode: Node<T>?) {
		print(">>> Entering replace(node=\(node),newNode=\(newNode))")
        guard let sourceParent = sourceNode.parent else { return }
        
        if sourceNode.isLeftChild {
            sourceParent.left = newNode
			print("replace(node=\(node),newNode=\(newNode)): sourceParent.left → \(sourceParent.left)")
        } else {
            sourceParent.right = newNode
			print("replace(node=\(node),newNode=\(newNode)): sourceParent.right → \(sourceParent.right)")
        }
        
        newNode?.parent = sourceParent
		print("<<< Exiting replace(node=\(node),newNode=\(newNode))")
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
		print(">>> Entering contains(value=\(value))")
		print("<<< Exiting contains(value=\(value))")
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
		print(">>> Entering depth()")
        var node = self
        var edges = 0
        while case let parent? = node.parent {
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
    public func predecessor() -> Node<T>? {
		print(">>> Entering predecessor()")
        if let left = left {
            return left.maximum()
        } else {
            var node = self
            while case let parent? = node.parent, parent.value != nil, value != nil {
                if parent.value! < value! { return parent }
                node = parent
            }
			print("<<< Exiting predecessor()")
            return nil
        }
    }
    
    /*
     Finds the node whose value succeeds our value in sorted order.
     */
    public func successor() -> Node<T>? {
		print(">>> Entering successor()")
        if let right = right {
            return right.minimum()
        } else {
            var node = self
            while case let parent? = node.parent, parent.value != nil , value != nil {
                if parent.value! > value! { return parent }
                node = parent
            }
			print("<<< Exiting successor()")
            return nil
        }
    }
}

// MARK: - Traversal
extension Node {
    
    public func traverseInOrder(process: (T) -> Void) {
		print(">>> Entering traverseInOrder(process=\(process))")
        left?.traverseInOrder(process: process)
        process(value!)
        right?.traverseInOrder(process: process)
		print("<<< Exiting traverseInOrder(process=\(process))")
    }
    
    public func traversePreOrder(process: (T) -> Void) {
		print(">>> Entering traversePreOrder(process=\(process))")
        process(value!)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
		print("<<< Exiting traversePreOrder(process=\(process))")
    }
    
    public func traversePostOrder(process: (T) -> Void) {
		print(">>> Entering traversePostOrder(process=\(process))")
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value!)
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
        a.append(formula(value!))
        if let right = right { a += right.map(formula: formula) }
		print("<<< Exiting map(formula=\(formula))")
        return a
    }
}

/*
 Is this binary tree a valid binary search tree?
 */
extension Node {
    
    public func isBST(minValue: T, maxValue: T) -> Bool {
		print(">>> Entering isBST(minValue=\(minValue),maxValue=\(maxValue))")
        if let value = value {
            if value < minValue || value > maxValue { return false }
            let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
			print("isBST(minValue=\(minValue),maxValue=\(maxValue)): leftBST → \(leftBST)")
			print("isBST(minValue=\(minValue),maxValue=\(maxValue)): rightBST → \(rightBST)")
            let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
		print("<<< Exiting isBST(minValue=\(minValue),maxValue=\(maxValue))")
            return leftBST && rightBST
        }
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
        var s = "value: \(value)"
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
		print(">>> Entering toArray()")
		print("<<< Exiting toArray()")
        return map { $0 }
    }
}

extension SplayTree: CustomDebugStringConvertible {
    public var debugDescription: String {
        return root?.debugDescription ?? "Empty tree"
    }
}
