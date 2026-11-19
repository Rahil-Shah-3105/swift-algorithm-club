import Foundation

public func randomArrayOfSets<T>(covering universe: Set<T>,
                              minArraySizeFactor: Double = 0.8,
                              maxSetSizeFactor: Double = 0.6) -> Array<Set<T>> {
							FileHandle.standardError.write(Data("[ERROR] >>> Entering randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor))\n".utf8))
  var result = [Set<T>]()
  var ongoingUnion = Set<T>()

FileHandle.standardError.write(Data("[ERROR] randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): ongoingUnion → \(ongoingUnion)\n".utf8))
FileHandle.standardError.write(Data("[ERROR] randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): result → \(result)\n".utf8))
  let minArraySize = Int(Double(universe.count) * minArraySizeFactor)
  var maxSetSize = Int(Double(universe.count) * maxSetSizeFactor)
  if maxSetSize > universe.count {
FileHandle.standardError.write(Data("[ERROR] randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): minArraySize → \(minArraySize)\n".utf8))
    maxSetSize = universe.count
  }

  while true {
    var generatedSet = Set<T>()
    let targetSetSize = Int.random(in: 0...maxSetSize) + 1
	FileHandle.standardError.write(Data("[ERROR] randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): generatedSet → \(generatedSet)\n".utf8))

    while true {
      let randomUniverseIndex = Int.random(in: 0...universe.count)
      for (setIndex, value) in universe.enumerated() {
	FileHandle.standardError.write(Data("[ERROR] randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor)): randomUniverseIndex → \(randomUniverseIndex)\n".utf8))
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

FileHandle.standardError.write(Data("[WARN] <<< Exiting randomArrayOfSets(universe=\(universe),minArraySizeFactor=\(minArraySizeFactor),maxSetSizeFactor=\(maxSetSizeFactor))\n".utf8))
  return result
}
