//
//  Multiset.swift
//  Multiset
//
//  Created by Simon Whitaker on 28/08/2017.
//

import Foundation

public struct Multiset<T: Hashable> {
  private var storage: [T: UInt] = [:]
  public private(set) var count: UInt = 0

  public init() {}

  public init<C: Collection>(_ collection: C) where C.Element == T {
    for element in collection {
      self.add(element)
    }
  }

  public mutating func add (_ elem: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering add(elem=\(elem))\n".utf8))
    storage[elem, default: 0] += 1
    count += 1
	FileHandle.standardError.write(Data("[WARN] <<< Exiting add(elem=\(elem))\n".utf8))
  }

  public mutating func remove (_ elem: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(elem=\(elem))\n".utf8))
    if let currentCount = storage[elem] {
      if currentCount > 1 {
        storage[elem] = currentCount - 1
      } else {
        storage.removeValue(forKey: elem)
      }
      count -= 1
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(elem=\(elem))\n".utf8))
  }

  public func isSubSet (of superset: Multiset<T>) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering isSubSet(superset=\(superset))\n".utf8))
    for (key, count) in storage {
      let supersetcount = superset.storage[key] ?? 0
      if count > supersetcount {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering count(key=\(key))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting count(key=\(key))\n".utf8))
        return false
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting isSubSet(superset=\(superset))\n".utf8))
    return true
  }

  public func count(for key: T) -> UInt {
    return storage[key] ?? 0
  }

  public var allItems: [T] {
    var result = [T]()
    for (key, count) in storage {
      for _ in 0 ..< count {
        result.append(key)
      }
    }
    return result
  }
}

// MARK: - Equatable
extension Multiset: Equatable {
  public static func == (lhs: Multiset<T>, rhs: Multiset<T>) -> Bool {
    if lhs.storage.count != rhs.storage.count {
      return false
    }
    for (lkey, lcount) in lhs.storage {
      let rcount = rhs.storage[lkey] ?? 0
      if lcount != rcount {
        return false
      }
    }
    return true
  }
}

// MARK: - ExpressibleByArrayLiteral
extension Multiset: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: T...) {
    self.init(elements)
  }
}
