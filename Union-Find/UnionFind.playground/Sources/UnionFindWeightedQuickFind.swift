import Foundation

/// Quick-find algorithm may take ~MN steps
/// to process M union commands on N objects
public struct UnionFindWeightedQuickFind<T: Hashable> {
  private var index = [T: Int]()
  private var parent = [Int]()
  private var size = [Int]()

  public init() {}

  public mutating func addSetWith(_ element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addSetWith(element=\(element))\n".utf8))
    index[element] = parent.count
    parent.append(parent.count)
    size.append(1)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addSetWith(element=\(element))\n".utf8))
  }

  private mutating func setByIndex(_ index: Int) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering setByIndex(index=\(index))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting setByIndex(index=\(index))\n".utf8))
    return parent[index]
  }

  public mutating func setOf(_ element: T) -> Int? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering setOf(element=\(element))\n".utf8))
    if let indexOfElement = index[element] {
      return setByIndex(indexOfElement)
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting setOf(element=\(element))\n".utf8))
      return nil
    }
  }

  public mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering unionSetsContaining(firstElement=\(firstElement),secondElement=\(secondElement))\n".utf8))
    if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
      if firstSet != secondSet {
        if size[firstSet] < size[secondSet] {
          for index in 0..<parent.count {
            if parent[index] == firstSet {
              parent[index] = secondSet
            }
          }
          size[secondSet] += size[firstSet]
        } else {
          for index in 0..<parent.count {
            if parent[index] == secondSet {
              parent[index] = firstSet
            }
          }
          size[firstSet] += size[secondSet]
        }
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting unionSetsContaining(firstElement=\(firstElement),secondElement=\(secondElement))\n".utf8))
  }

  public mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering inSameSet(firstElement=\(firstElement),secondElement=\(secondElement))\n".utf8))
    if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
      return firstSet == secondSet
    } else {
	FileHandle.standardError.write(Data("[WARN] <<< Exiting inSameSet(firstElement=\(firstElement),secondElement=\(secondElement))\n".utf8))
      return false
    }
  }
}
