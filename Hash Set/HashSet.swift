public struct HashSet<T: Hashable> {
  private var dictionary = Dictionary<T, Bool>()

  public mutating func insert(element: T) {
	print(">>> Entering insert(element=\(element))")
    dictionary[element] = true
	print("<<< Exiting insert(element=\(element))")
  }

  public mutating func remove(element: T) {
	print(">>> Entering remove(element=\(element))")
    dictionary[element] = nil
	print("<<< Exiting remove(element=\(element))")
  }

  public func contains(element: T) -> Bool {
	print(">>> Entering contains(element=\(element))")
	print("<<< Exiting contains(element=\(element))")
    return dictionary[element] != nil
  }

  public func allElements() -> [T] {
	print(">>> Entering allElements()")
	print("<<< Exiting allElements()")
    return Array(dictionary.keys)
  }

  public var count: Int {
    return dictionary.count
  }

  public var isEmpty: Bool {
    return dictionary.isEmpty
  }
}

extension HashSet {
  public func union(otherSet: HashSet<T>) -> HashSet<T> {
	print(">>> Entering union(otherSet=\(otherSet))")
    var combined = HashSet<T>()
    for obj in dictionary.keys {
	print("union(otherSet=\(otherSet)): combined → \(combined)")
      combined.insert(obj)
    }
    for obj in otherSet.dictionary.keys {
      combined.insert(obj)
    }
	print("<<< Exiting union(otherSet=\(otherSet))")
    return combined
  }

  public func intersect(otherSet: HashSet<T>) -> HashSet<T> {
	print(">>> Entering intersect(otherSet=\(otherSet))")
    var common = HashSet<T>()
    for obj in dictionary.keys {
	print("intersect(otherSet=\(otherSet)): common → \(common)")
      if otherSet.contains(obj) {
        common.insert(obj)
      }
    }
	print("<<< Exiting intersect(otherSet=\(otherSet))")
    return common
  }

  public func difference(otherSet: HashSet<T>) -> HashSet<T> {
	print(">>> Entering difference(otherSet=\(otherSet))")
    var diff = HashSet<T>()
    for obj in dictionary.keys {
	print("difference(otherSet=\(otherSet)): diff → \(diff)")
      if !otherSet.contains(obj) {
        diff.insert(obj)
      }
    }
	print("<<< Exiting difference(otherSet=\(otherSet))")
    return diff
  }
}
