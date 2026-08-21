public extension Set {
  func cover(within array: Array<Set<Element>>) -> Array<Set<Element>>? {
	print(">>> Entering cover(array=\(array))")
    var result: [Set<Element>]? = [Set<Element>]()
    var remainingSet = self

    func largestIntersectingSet() -> Set<Element>? {
	print(">>> Entering largestIntersectingSet()")
      var largestIntersectionLength = 0
      var largestSet: Set<Element>?

      for set in array {
        let intersectionLength = remainingSet.intersection(set).count
		print("largestIntersectingSet(): intersectionLength → \(intersectionLength)")
        if intersectionLength > largestIntersectionLength {
          largestIntersectionLength = intersectionLength
          largestSet = set
		print("largestIntersectingSet(): largestSet → \(largestSet)")
        }
      }

	print("<<< Exiting largestIntersectingSet()")
      return largestSet
    }

    while !remainingSet.isEmpty {
      guard let largestSet = largestIntersectingSet() else { break }
      result!.append(largestSet)
      remainingSet = remainingSet.subtracting(largestSet)
    }

    if !remainingSet.isEmpty || isEmpty {
      result = nil
    }

	print("<<< Exiting cover(array=\(array))")
    return result
  }
}
