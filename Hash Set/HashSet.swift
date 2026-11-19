import Foundation
public struct HashSet<T: Hashable> {
  private var dictionary = Dictionary<T, Bool>()

  public mutating func insert(element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(element=\(element))\n".utf8))
    dictionary[element] = true
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(element=\(element))\n".utf8))
  }

  public mutating func remove(element: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(element=\(element))\n".utf8))
    dictionary[element] = nil
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(element=\(element))\n".utf8))
  }

  public func contains(element: T) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering contains(element=\(element))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting contains(element=\(element))\n".utf8))
    return dictionary[element] != nil
  }

  public func allElements() -> [T] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering allElements()\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting allElements()\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering union(otherSet=\(otherSet))\n".utf8))
    var combined = HashSet<T>()
    for obj in dictionary.keys {
	FileHandle.standardError.write(Data("[ERROR] union(otherSet=\(otherSet)): combined → \(combined)\n".utf8))
      combined.insert(obj)
    }
    for obj in otherSet.dictionary.keys {
      combined.insert(obj)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting union(otherSet=\(otherSet))\n".utf8))
    return combined
  }

  public func intersect(otherSet: HashSet<T>) -> HashSet<T> {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering intersect(otherSet=\(otherSet))\n".utf8))
    var common = HashSet<T>()
    for obj in dictionary.keys {
	FileHandle.standardError.write(Data("[ERROR] intersect(otherSet=\(otherSet)): common → \(common)\n".utf8))
      if otherSet.contains(obj) {
        common.insert(obj)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting intersect(otherSet=\(otherSet))\n".utf8))
    return common
  }

  public func difference(otherSet: HashSet<T>) -> HashSet<T> {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering difference(otherSet=\(otherSet))\n".utf8))
    var diff = HashSet<T>()
    for obj in dictionary.keys {
	FileHandle.standardError.write(Data("[ERROR] difference(otherSet=\(otherSet)): diff → \(diff)\n".utf8))
      if !otherSet.contains(obj) {
        diff.insert(obj)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting difference(otherSet=\(otherSet))\n".utf8))
    return diff
  }
}
