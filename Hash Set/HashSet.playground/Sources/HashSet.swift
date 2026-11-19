import Foundation
//: Playground - noun: a place where people can play

public struct HashSet<T: Hashable> {
    fileprivate var dictionary = Dictionary<T, Bool>()

    public init() {

    }

    public mutating func insert(_ element: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(element=\(element))\n".utf8))
        dictionary[element] = true
		FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(element=\(element))\n".utf8))
    }

    public mutating func remove(_ element: T) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(element=\(element))\n".utf8))
        dictionary[element] = nil
		FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(element=\(element))\n".utf8))
    }

    public func contains(_ element: T) -> Bool {
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

/* Union */

extension HashSet {
    public func union(_ otherSet: HashSet<T>) -> HashSet<T> {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering union(otherSet=\(otherSet))\n".utf8))
        var combined = HashSet<T>()
        for obj in self.dictionary.keys {
			FileHandle.standardError.write(Data("[ERROR] union(otherSet=\(otherSet)): combined → \(combined)\n".utf8))
            combined.insert(obj)
        }
        for obj in otherSet.dictionary.keys {
            combined.insert(obj)
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting union(otherSet=\(otherSet))\n".utf8))
        return combined
    }
}

/* Intersection */

extension HashSet {
    public func intersect(_ otherSet: HashSet<T>) -> HashSet<T> {
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
}

/* Difference */

extension HashSet {
    public func difference(_ otherSet: HashSet<T>) -> HashSet<T> {
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
