import Foundation
public extension Set {
  func cover(within array: Array<Set<Element>>) -> Array<Set<Element>>? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering cover(array=\(array))\n".utf8))
    var result: [Set<Element>]? = [Set<Element>]()
    var remainingSet = self

    func largestIntersectingSet() -> Set<Element>? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering largestIntersectingSet()\n".utf8))
      var largestIntersectionLength = 0
      var largestSet: Set<Element>?

      for set in array {
        let intersectionLength = remainingSet.intersection(set).count
		FileHandle.standardError.write(Data("[ERROR] cover(array=\(array)): intersectionLength → \(intersectionLength)\n".utf8))
        if intersectionLength > largestIntersectionLength {
		FileHandle.standardError.write(Data("[ERROR] largestIntersectingSet(): intersectionLength → \(intersectionLength)\n".utf8))
          largestIntersectionLength = intersectionLength
          largestSet = set
		FileHandle.standardError.write(Data("[DEBUG] largestIntersectingSet(): largestSet → \(largestSet)\n".utf8))
        }
      }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting largestIntersectingSet()\n".utf8))
      return largestSet
    }

    while !remainingSet.isEmpty {
      guard let largestSet = largestIntersectingSet() else { break }
	FileHandle.standardError.write(Data("[ERROR] cover(array=\(array)): largestSet → \(largestSet)\n".utf8))
      result!.append(largestSet)
      remainingSet = remainingSet.subtracting(largestSet)
    }

    if !remainingSet.isEmpty || isEmpty {
      result = nil
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting cover(array=\(array))\n".utf8))
    return result
  }
}
