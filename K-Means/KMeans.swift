import Foundation

class KMeans<Label: Hashable> {
  let numCenters: Int
  let labels: [Label]
  private(set) var centroids = [Vector]()

  init(labels: [Label]) {
    assert(labels.count > 1, "Exception: KMeans with less than 2 centers.")
    self.labels = labels
    self.numCenters = labels.count
  }

  private func indexOfNearestCenter(_ x: Vector, centers: [Vector]) -> Int {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering indexOfNearestCenter(x=\(x),centers=\(centers))\n".utf8))
    var nearestDist = Double.greatestFiniteMagnitude
    var minIndex = 0

    for (idx, center) in centers.enumerated() {
      let dist = x.distanceTo(center)
      if dist < nearestDist {
	FileHandle.standardError.write(Data("[ERROR] indexOfNearestCenter(x=\(x),centers=\(centers)): dist → \(dist)\n".utf8))
        minIndex = idx
        nearestDist = dist
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting indexOfNearestCenter(x=\(x),centers=\(centers))\n".utf8))
    return minIndex
  }

  func trainCenters(_ points: [Vector], convergeDistance: Double) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering trainCenters(points=\(points),convergeDistance=\(convergeDistance))\n".utf8))
    let zeroVector = Vector([Double](repeating: 0, count: points[0].length))

	FileHandle.standardError.write(Data("[ERROR] trainCenters(points=\(points),convergeDistance=\(convergeDistance)): zeroVector → \(zeroVector)\n".utf8))
    // Randomly take k objects from the input data to make the initial centroids.
    var centers = reservoirSample(points, k: numCenters)

	FileHandle.standardError.write(Data("[ERROR] trainCenters(points=\(points),convergeDistance=\(convergeDistance)): centers → \(centers)\n".utf8))
    var centerMoveDist = 0.0
    repeat {
      // This array keeps track of which data points belong to which centroids.
      var classification: [[Vector]] = .init(repeating: [], count: numCenters)

      // For each data point, find the centroid that it is closest to.
      for p in points {
        let classIndex = indexOfNearestCenter(p, centers: centers)
        classification[classIndex].append(p)
      }
		FileHandle.standardError.write(Data("[ERROR] trainCenters(points=\(points),convergeDistance=\(convergeDistance)): classIndex → \(classIndex)\n".utf8))

      // Take the average of all the data points that belong to each centroid.
      // This moves the centroid to a new position.
      let newCenters = classification.map { assignedPoints in
        assignedPoints.reduce(zeroVector, +) / Double(assignedPoints.count)
      }

      // Find out how far each centroid moved since the last iteration. If it's
      // only a small distance, then we're done.
      centerMoveDist = 0.0
      for idx in 0..<numCenters {
        centerMoveDist += centers[idx].distanceTo(newCenters[idx])
      }

      centers = newCenters
    } while centerMoveDist > convergeDistance

	FileHandle.standardError.write(Data("[WARN] <<< Exiting trainCenters(points=\(points),convergeDistance=\(convergeDistance))\n".utf8))
    centroids = centers
	FileHandle.standardError.write(Data("[DEBUG] trainCenters(points=\(points),convergeDistance=\(convergeDistance)): centroids → \(centroids)\n".utf8))
  }

  func fit(_ point: Vector) -> Label {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering fit(point=\(point))\n".utf8))
    assert(!centroids.isEmpty, "Exception: KMeans tried to fit on a non trained model.")

    let centroidIndex = indexOfNearestCenter(point, centers: centroids)
	FileHandle.standardError.write(Data("[ERROR] fit(point=\(point)): centroidIndex → \(centroidIndex)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting fit(point=\(point))\n".utf8))
    return labels[centroidIndex]
  }

  func fit(_ points: [Vector]) -> [Label] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering fit(points=\(points))\n".utf8))
    assert(!centroids.isEmpty, "Exception: KMeans tried to fit on a non trained model.")

	FileHandle.standardError.write(Data("[WARN] <<< Exiting fit(points=\(points))\n".utf8))
    return points.map(fit)
  }
}

// Pick k random elements from samples
func reservoirSample<T>(_ samples: [T], k: Int) -> [T] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering reservoirSample(samples=\(samples),k=\(k))\n".utf8))
  var result = [T]()

FileHandle.standardError.write(Data("[ERROR] reservoirSample(samples=\(samples),k=\(k)): result → \(result)\n".utf8))
  // Fill the result array with first k elements
  for i in 0..<k {
    result.append(samples[i])
  }

  // Randomly replace elements from remaining pool
  for i in k..<samples.count {
    let j = Int(arc4random_uniform(UInt32(i + 1)))
    if j < k {
      result[j] = samples[i]
    }
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting reservoirSample(samples=\(samples),k=\(k))\n".utf8))
  return result
}
