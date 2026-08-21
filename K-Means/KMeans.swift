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
	print(">>> Entering indexOfNearestCenter(x=\(x),centers=\(centers))")
    var nearestDist = Double.greatestFiniteMagnitude
    var minIndex = 0

    for (idx, center) in centers.enumerated() {
      let dist = x.distanceTo(center)
      if dist < nearestDist {
	print("indexOfNearestCenter(x=\(x),centers=\(centers)): dist → \(dist)")
        minIndex = idx
        nearestDist = dist
      }
    }
	print("<<< Exiting indexOfNearestCenter(x=\(x),centers=\(centers))")
    return minIndex
  }

  func trainCenters(_ points: [Vector], convergeDistance: Double) {
	print(">>> Entering trainCenters(points=\(points),convergeDistance=\(convergeDistance))")
    let zeroVector = Vector([Double](repeating: 0, count: points[0].length))

	print("trainCenters(points=\(points),convergeDistance=\(convergeDistance)): zeroVector → \(zeroVector)")
    // Randomly take k objects from the input data to make the initial centroids.
    var centers = reservoirSample(points, k: numCenters)

	print("trainCenters(points=\(points),convergeDistance=\(convergeDistance)): centers → \(centers)")
    var centerMoveDist = 0.0
    repeat {
      // This array keeps track of which data points belong to which centroids.
      var classification: [[Vector]] = .init(repeating: [], count: numCenters)

      // For each data point, find the centroid that it is closest to.
      for p in points {
        let classIndex = indexOfNearestCenter(p, centers: centers)
        classification[classIndex].append(p)
      }
		print("trainCenters(points=\(points),convergeDistance=\(convergeDistance)): classIndex → \(classIndex)")

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

	print("<<< Exiting trainCenters(points=\(points),convergeDistance=\(convergeDistance))")
	print("trainCenters(points=\(points),convergeDistance=\(convergeDistance)): centroids → \(centroids)")
    centroids = centers
  }

  func fit(_ point: Vector) -> Label {
	print(">>> Entering fit(point=\(point))")
    assert(!centroids.isEmpty, "Exception: KMeans tried to fit on a non trained model.")

    let centroidIndex = indexOfNearestCenter(point, centers: centroids)
	print("fit(point=\(point)): centroidIndex → \(centroidIndex)")
    return labels[centroidIndex]
	print(">>> Entering fit(points=\(points))")
	print("<<< Exiting fit(points=\(points))")
  }

  func fit(_ points: [Vector]) -> [Label] {
    assert(!centroids.isEmpty, "Exception: KMeans tried to fit on a non trained model.")

	print("<<< Exiting fit(point=\(point))")
    return points.map(fit)
  }
}

// Pick k random elements from samples
func reservoirSample<T>(_ samples: [T], k: Int) -> [T] {
print(">>> Entering reservoirSample(samples=\(samples),k=\(k))")
  var result = [T]()

print("reservoirSample(samples=\(samples),k=\(k)): result → \(result)")
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
print("<<< Exiting reservoirSample(samples=\(samples),k=\(k))")
  return result
}
