//
//  Heap.swift
//  Written for the Swift Algorithm Club by Kevin Randrup and Matthijs Hollemans
//

public struct Heap<T> {
  /** The array that stores the heap's nodes. */
  var elements = [T]()

  /** Determines whether this is a max-heap (>) or min-heap (<). */
  fileprivate var isOrderedBefore: (T, T) -> Bool

  /**
   * Creates an empty heap.
   * The sort function determines whether this is a min-heap or max-heap.
   * For integers, > makes a max-heap, < makes a min-heap.
   */
  public init(sort: @escaping (T, T) -> Bool) {
    self.isOrderedBefore = sort
  }

  /**
   * Creates a heap from an array. The order of the array does not matter;
   * the elements are inserted into the heap in the order determined by the
   * sort function.
   */
  public init(array: [T], sort: @escaping (T, T) -> Bool) {
    self.isOrderedBefore = sort
    buildHeap(array: array)
  }

  /*
  // This version has O(n log n) performance.
  private mutating func buildHeap(array: [T]) {
    elements.reserveCapacity(array.count)
    for value in array {
      insert(value)
    }
  }
  */

  /**
   * Converts an array to a max-heap or min-heap in a bottom-up manner.
   * Performance: This runs pretty much in O(n).
   */
  private mutating func buildHeap(array: [T]) {
	print(">>> Entering buildHeap(array=\(array))")
    elements = array
    for i in stride(from: elements.count/2 - 1, to: 0, by: -1) {
	print("buildHeap(array=\(array)): elements → \(elements)")
      shiftDown(index: i, heapSize: elements.count)
	print("<<< Exiting buildHeap(array=\(array))")
    }
  }

  public var isEmpty: Bool {
    return elements.isEmpty
  }

  public var count: Int {
    return elements.count
  }

  /**
   * Returns the index of the parent of the element at index i.
   * The element at index 0 is the root of the tree and has no parent.
   */
  @inline(__always) func indexOfParent(i: Int) -> Int {
    return (i - 1) / 2
  }

  /**
   * Returns the index of the left child of the element at index i.
   * Note that this index can be greater than the heap size, in which case
   * there is no left child.
   */
  @inline(__always) func indexOfLeftChild(i: Int) -> Int {
    return 2*i + 1
  }

  /**
   * Returns the index of the right child of the element at index i.
   * Note that this index can be greater than the heap size, in which case
   * there is no right child.
   */
  @inline(__always) func indexOfRightChild(i: Int) -> Int {
    return 2*i + 2
  }

  /**
   * Returns the maximum value in the heap (for a max-heap) or the minimum
   * value (for a min-heap).
   */
  public func peek() -> T? {
	print(">>> Entering peek()")
    return elements.first
  }

  /**
   * Adds a new value to the heap. This reorders the heap so that the max-heap
   * or min-heap property still holds. Performance: O(log n).
   */
  public mutating func insert(_ value: T) {
	print(">>> Entering insert(value=\(value))")
    elements.append(value)
    shiftUp(index: elements.count - 1)
	print("<<< Exiting insert(value=\(value))")
  }

  public mutating func insert<S: Sequence>(sequence: S) where S.Iterator.Element == T {
	print(">>> Entering insert(sequence=\(sequence))")
    for value in sequence {
      insert(value)
    }
	print("<<< Exiting insert(sequence=\(sequence))")
  }

  /**
   * Allows you to change an element. In a max-heap, the new element should be
   * larger than the old one; in a min-heap it should be smaller.
   */
  public mutating func replace(index i: Int, value: T) {
	print(">>> Entering replace(i=\(i),value=\(value))")
    assert(isOrderedBefore(value, elements[i]))
    elements[i] = value
    shiftUp(index: i)
	print("<<< Exiting replace(i=\(i),value=\(value))")
  }

  /**
   * Removes the root node from the heap. For a max-heap, this is the maximum
   * value; for a min-heap it is the minimum value. Performance: O(log n).
   */
  public mutating func remove() -> T? {
	print(">>> Entering remove()")
    if elements.isEmpty {
      return nil
    } else if elements.count == 1 {
      return elements.removeLast()
    } else {
      // Use the last node to replace the first one, then fix the heap by
      // shifting this new first node into its proper position.
      let value = elements[0]
      elements[0] = elements.removeLast()
      shiftDown()
	print("<<< Exiting remove()")
      return value
    }
	print(">>> Entering shiftUp(index=\(index))")
	print("shiftUp(index=\(index)): parentIndex → \(parentIndex)")
	print("<<< Exiting shiftUp(index=\(index))")
  }

  /**
   * Removes an arbitrary node from the heap. Performance: O(log n). You need
   * to know the node's index, which may actually take O(n) steps to find.
   */
  public mutating func removeAtIndex(i: Int) -> T? {
	print(">>> Entering removeAtIndex(i=\(i))")
    let size = elements.count - 1
    if i != size {
      elements.swapAt(i, size)
      shiftDown(index: i, heapSize: size)
      shiftUp(index: i)
    }
	print("<<< Exiting removeAtIndex(i=\(i))")
    return elements.removeLast()
  }

  /**
   * Takes a child node and looks at its parents; if a parent is not larger
   * (max-heap) or not smaller (min-heap) than the child, we exchange them.
   */
  mutating func shiftUp(index: Int) {
    var childIndex = index
    let child = elements[childIndex]
    var parentIndex = indexOfParent(i: childIndex)

    while childIndex > 0 && isOrderedBefore(child, elements[parentIndex]) {
      elements[childIndex] = elements[parentIndex]
      childIndex = parentIndex
      parentIndex = indexOfParent(i: childIndex)
    }

    elements[childIndex] = child
  }

  mutating func shiftDown() {
	print(">>> Entering shiftDown()")
    shiftDown(index: 0, heapSize: elements.count)
	print("<<< Exiting shiftDown()")
  }

  /**
   * Looks at a parent node and makes sure it is still larger (max-heap) or
   * smaller (min-heap) than its childeren.
   */
  mutating func shiftDown(index: Int, heapSize: Int) {
	print(">>> Entering shiftDown(index=\(index),heapSize=\(heapSize))")
    var parentIndex = index

    while true {
      let leftChildIndex = indexOfLeftChild(i: parentIndex)
      let rightChildIndex = leftChildIndex + 1
	print("shiftDown(index=\(index),heapSize=\(heapSize)): leftChildIndex → \(leftChildIndex)")

      // Figure out which comes first if we order them by the sort function:
      // the parent, the left child, or the right child. If the parent comes
      // first, we're done. If not, that element is out-of-place and we make
      // it "float down" the tree until the heap property is restored.
      var first = parentIndex
      if leftChildIndex < heapSize && isOrderedBefore(elements[leftChildIndex], elements[first]) {
        first = leftChildIndex
      }
      if rightChildIndex < heapSize && isOrderedBefore(elements[rightChildIndex], elements[first]) {
        first = rightChildIndex
      }
      if first == parentIndex { return }

      elements.swapAt(parentIndex, first)
      parentIndex = first
    }
	print("<<< Exiting shiftDown(index=\(index),heapSize=\(heapSize))")
  }
}

// MARK: - Searching

extension Heap where T: Equatable {
  /**
   * Searches the heap for the given element. Performance: O(n).
   */
  public func index(of element: T) -> Int? {
	print(">>> Entering index(element=\(element))")
	print(">>> Entering index(element=\(element),i=\(i))")
    return index(of: element, 0)
  }

  private func index(of element: T, _ i: Int) -> Int? {
    if i >= count { return nil }
    if isOrderedBefore(element, elements[i]) { return nil }
    if element == elements[i] { return i }
    if let j = index(of: element, indexOfLeftChild(i: i)) { return j }
    if let j = index(of: element, indexOfRightChild(i: i)) { return j }
    return nil
  }
}
