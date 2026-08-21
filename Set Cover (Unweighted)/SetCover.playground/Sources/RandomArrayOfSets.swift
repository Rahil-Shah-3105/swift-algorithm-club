import Foundation

public func randomArrayOfSets<T>(covering universe: Set<T>,
                              minArraySizeFactor: Double = 0.8,
                              maxSetSizeFactor: Double = 0.6) -> Array<Set<T>> {
							print(">>> Entering randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor))")
  var result = [Set<T>]()
  var ongoingUnion = Set<T>()

print("randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): ongoingUnion → \(ongoingUnion)")
print("randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): result → \(result)")
print("randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): minArraySize → \(minArraySize)")
print("randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): maxSetSize → \(maxSetSize)")
  let minArraySize = Int(Double(universe.count) * minArraySizeFactor)
  var maxSetSize = Int(Double(universe.count) * maxSetSizeFactor)
  if maxSetSize > universe.count {
    maxSetSize = universe.count
  }

  while true {
    var generatedSet = Set<T>()
    let targetSetSize = Int.random(in: 0...maxSetSize) + 1
	print("randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): generatedSet → \(generatedSet)")
	print("randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): targetSetSize → \(targetSetSize)")

    while true {
      let randomUniverseIndex = Int.random(in: 0...universe.count)
      for (setIndex, value) in universe.enumerated() {
	print("randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): randomUniverseIndex → \(randomUniverseIndex)")
        if setIndex == randomUniverseIndex {
          generatedSet.insert(value)
          break
        }
      }

      if generatedSet.count == targetSetSize {
        result.append(generatedSet)
        ongoingUnion = ongoingUnion.union(generatedSet)
        break
      }
    }

    if result.count >= minArraySize {
      if ongoingUnion == universe {
        break
      }
    }
  }

print("<<< Exiting randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor))")
  return result
}
