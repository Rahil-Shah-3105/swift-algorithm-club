import Foundation
//
//  Heap.swift
//  Written for the Swift Algorithm Club by Kevin Randrup and Matthijs Hollemans
//

public struct Heap<T> {
  
  /** The array that stores the heap's nodes. */
  var nodes = [T]()
  
  /**
   * Determines how to compare two nodes in the heap.
   * Use '>' for a max-heap or '<' for a min-heap,
   * or provide a comparing method if the heap is made
   * of custom elements, for example tuples.
   */
  private var orderCriteria: (T, T) -> Bool
  
  /**
   * Creates an empty heap.
   * The sort function determines whether this is a min-heap or max-heap.
   * For comparable data types, > makes a max-heap, < makes a min-heap.
   */
  public init(sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
  }
  
  /**
   * Creates a heap from an array. The order of the array does not matter;
   * the elements are inserted into the heap in the order determined by the
   * sort function. For comparable data types, '>' makes a max-heap,
   * '<' makes a min-heap.
   */
  public init(array: [T], sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
    configureHeap(from: array)
  }
  
  /**
   * Configures the max-heap or min-heap from an array, in a bottom-up manner.
   * Performance: This runs pretty much in O(n).
   */
  private mutating func configureHeap(from array: [T]) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering configureHeap(array=\(array))\n".utf8))
    nodes = array
    for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
	FileHandle.standardError.write(Data("[DEBUG] configureHeap(array=\(array)): nodes → \(nodes)\n".utf8))
      shiftDown(i)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting configureHeap(array=\(array))\n".utf8))
  }
  
  public var isEmpty: Bool {
    return nodes.isEmpty
  }
  
  public var count: Int {
    return nodes.count
  }
  
  /**
   * Returns the index of the parent of the element at index i.
   * The element at index 0 is the root of the tree and has no parent.
   */
  @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int {
    return (i - 1) / 2
  }
  
  /**
   * Returns the index of the left child of the element at index i.
   * Note that this index can be greater than the heap size, in which case
   * there is no left child.
   */
  @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 1
  }
  
  /**
   * Returns the index of the right child of the element at index i.
   * Note that this index can be greater than the heap size, in which case
   * there is no right child.
   */
  @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 2
  }
  
  /**
   * Returns the maximum value in the heap (for a max-heap) or the minimum
   * value (for a min-heap).
   */
  public func peek() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering peek()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting peek()\n".utf8))
    return nodes.first
  }
  
  /**
   * Adds a new value to the heap. This reorders the heap so that the max-heap
   * or min-heap property still holds. Performance: O(log n).
   */
  public mutating func insert(_ value: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(value=\(value))\n".utf8))
    nodes.append(value)
    shiftUp(nodes.count - 1)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(value=\(value))\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(sequence=\(sequence))\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(sequence=\(sequence))\n".utf8))
  }
  
  /**
   * Adds a sequence of values to the heap. This reorders the heap so that
   * the max-heap or min-heap property still holds. Performance: O(log n).
   */
  public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
    for value in sequence {
      insert(value)
    }
  }
  
  /**
   * Allows you to change an element. This reorders the heap so that
   * the max-heap or min-heap property still holds.
   */
  public mutating func replace(index i: Int, value: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering replace(i=\(i),value=\(value))\n".utf8))
    guard i < nodes.count else { return }
    
    remove(at: i)
    insert(value)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting replace(i=\(i),value=\(value))\n".utf8))
  }
  
  /**
   * Removes the root node from the heap. For a max-heap, this is the maximum
   * value; for a min-heap it is the minimum value. Performance: O(log n).
   */
  @discardableResult public mutating func remove() -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove()\n".utf8))
    guard !nodes.isEmpty else { return nil }
    
    if nodes.count == 1 {
      return nodes.removeLast()
    } else {
      // Use the last node to replace the first one, then fix the heap by
      // shifting this new first node into its proper position.
      let value = nodes[0]
      nodes[0] = nodes.removeLast()
      shiftDown(0)
      return value
    }
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(index=\(index))\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove()\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(index=\(index))\n".utf8))
  }
  
  /**
   * Removes an arbitrary node from the heap. Performance: O(log n).
   * Note that you need to know the node's index.
   */
  @discardableResult public mutating func remove(at index: Int) -> T? {
    guard index < nodes.count else { return nil }
    
    let size = nodes.count - 1
    if index != size {
      nodes.swapAt(index, size)
      shiftDown(from: index, until: size)
      shiftUp(index)
    }
    return nodes.removeLast()
  }
  
  /**
   * Takes a child node and looks at its parents; if a parent is not larger
   * (max-heap) or not smaller (min-heap) than the child, we exchange them.
   */
  internal mutating func shiftUp(_ index: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering shiftUp(index=\(index))\n".utf8))
    var childIndex = index
    let child = nodes[childIndex]
    var parentIndex = self.parentIndex(ofIndex: childIndex)
    
	FileHandle.standardError.write(Data("[ERROR] shiftUp(index=\(index)): parentIndex → \(parentIndex)\n".utf8))
    while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
      nodes[childIndex] = nodes[parentIndex]
      childIndex = parentIndex
      parentIndex = self.parentIndex(ofIndex: childIndex)
    }
    
    nodes[childIndex] = child
	FileHandle.standardError.write(Data("[WARN] <<< Exiting shiftUp(index=\(index))\n".utf8))
  }
  
  /**
   * Looks at a parent node and makes sure it is still larger (max-heap) or
   * smaller (min-heap) than its childeren.
   */
  internal mutating func shiftDown(from index: Int, until endIndex: Int) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering shiftDown(index=\(index),endIndex=\(endIndex))\n".utf8))
    let leftChildIndex = self.leftChildIndex(ofIndex: index)
    let rightChildIndex = leftChildIndex + 1
	FileHandle.standardError.write(Data("[ERROR] shiftDown(index=\(index),endIndex=\(endIndex)): leftChildIndex → \(leftChildIndex)\n".utf8))
    
    // Figure out which comes first if we order them by the sort function:
    // the parent, the left child, or the right child. If the parent comes
    // first, we're done. If not, that element is out-of-place and we make
    // it "float down" the tree until the heap property is restored.
    var first = index
    if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
      first = leftChildIndex
    }
    if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
      first = rightChildIndex
    }
    if first == index { return }
    
    nodes.swapAt(index, first)
    shiftDown(from: first, until: endIndex)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting shiftDown(index=\(index),endIndex=\(endIndex))\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] >>> Entering shiftDown(index=\(index))\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting shiftDown(index=\(index))\n".utf8))
  }
  
  internal mutating func shiftDown(_ index: Int) {
    shiftDown(from: index, until: nodes.count)
  }
  
}

// MARK: - Searching

extension Heap where T: Equatable {
  
  /** Get the index of a node in the heap. Performance: O(n). */
  public func index(of node: T) -> Int? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering index(node=\(node))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting index(node=\(node))\n".utf8))
    return nodes.index(where: { $0 == node })
  }
  
  /** Removes the first occurrence of a node from the heap. Performance: O(n). */
  @discardableResult public mutating func remove(node: T) -> T? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(node=\(node))\n".utf8))
    if let index = index(of: node) {
      return remove(at: index)
    }
    return nil
  }
  
}
