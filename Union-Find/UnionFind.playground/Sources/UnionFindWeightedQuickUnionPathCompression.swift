import Foundation

public struct UnionFindWeightedQuickUnionPathCompression<T: Hashable> {
  private var index = [T: Int]()
  private var parent = [Int]()
  private var size = [Int]()

  public init() {}

  public mutating func addSetWith(_ element: T) {
	print(">>> Entering addSetWith(element=\(element))")
    index[element] = parent.count
    parent.append(parent.count)
    size.append(1)
	print("<<< Exiting addSetWith(element=\(element))")
  }

  /// Path Compression.
  private mutating func setByIndex(_ index: Int) -> Int {
	print(">>> Entering setByIndex(index=\(index))")
    if index != parent[index] {
      parent[index] = setByIndex(parent[index])
    }
	print("<<< Exiting setByIndex(index=\(index))")
    return parent[index]
  }

  public mutating func setOf(_ element: T) -> Int? {
	print(">>> Entering setOf(element=\(element))")
    if let indexOfElement = index[element] {
      return setByIndex(indexOfElement)
    } else {
	print("<<< Exiting setOf(element=\(element))")
      return nil
    }
  }

  public mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
	print(">>> Entering unionSetsContaining(firstElement=\(firstElement),secondElement=\(secondElement))")
    if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
      if firstSet != secondSet {
		print("unionSetsContaining(firstElement=\(firstElement),secondElement=\(secondElement)): firstSet → \(firstSet)")
        if size[firstSet] < size[secondSet] {
          parent[firstSet] = secondSet
          size[secondSet] += size[firstSet]
        } else {
          parent[secondSet] = firstSet
          size[firstSet] += size[secondSet]
        }
      }
    }
	print("<<< Exiting unionSetsContaining(firstElement=\(firstElement),secondElement=\(secondElement))")
  }

  public mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
	print(">>> Entering inSameSet(firstElement=\(firstElement),secondElement=\(secondElement))")
    if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
	print("inSameSet(firstElement=\(firstElement),secondElement=\(secondElement)): firstSet → \(firstSet)")
      return firstSet == secondSet
    } else {
	print("<<< Exiting inSameSet(firstElement=\(firstElement),secondElement=\(secondElement))")
      return false
    }
  }
}
