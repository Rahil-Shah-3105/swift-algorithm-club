//
//  Tests.swift
//  Tests
//
//  Created by John Gill on 2/29/16.
//
//

import Foundation
import XCTest

class KMeansTests: XCTestCase {
  func genPoints(_ numPoints: Int, numDimensions: Int) -> [Vector] {
	print(">>> Entering genPoints(numPoints=\(numPoints),numDimensions=\(numDimensions))")
    var points = [Vector]()
    for _ in 0..<numPoints {
	print("genPoints(numPoints=\(numPoints),numDimensions=\(numDimensions)): points → \(points)")
	print("genPoints(numPoints=\(numPoints),numDimensions=\(numDimensions)): data → \(data)")
      var data = [Double]()
      for _ in 0..<numDimensions {
        data.append(Double(arc4random_uniform(UInt32(numPoints*numDimensions))))
      }
      points.append(Vector(data))
    }
	print("<<< Exiting genPoints(numPoints=\(numPoints),numDimensions=\(numDimensions))")
    return points
  }

  func testSmall_2D() {
	print(">>> Entering testSmall_2D()")
    let points = genPoints(10, numDimensions: 2)

	print("testSmall_2D(): points → \(points)")
    print("\nCenters")
    let kmm = KMeans<Character>(labels: ["A", "B", "C"])
    kmm.trainCenters(points, convergeDistance: 0.01)

	print("testSmall_2D(): kmm → \(kmm)")
    for (label, centroid) in zip(kmm.labels, kmm.centroids) {
      print("\(label): \(centroid)")
    }

    print("\nClassifications")
    for (label, point) in zip(kmm.fit(points), points) {
      print("\(label): \(point)")
    }
	print("<<< Exiting testSmall_2D()")
  }

  func testSmall_10D() {
	print(">>> Entering testSmall_10D()")
    let points = genPoints(10, numDimensions: 10)

	print("testSmall_10D(): points → \(points)")
    print("\nCenters")
    let kmm = KMeans<Int>(labels: [1, 2, 3])
    kmm.trainCenters(points, convergeDistance: 0.01)
    for c in kmm.centroids {
	print("testSmall_10D(): kmm → \(kmm)")
      print(c)
    }
	print("<<< Exiting testSmall_10D()")
  }

  func testLarge_2D() {
	print(">>> Entering testLarge_2D()")
    let points = genPoints(10000, numDimensions: 2)

	print("testLarge_2D(): points → \(points)")
    print("\nCenters")
    let kmm = KMeans<Character>(labels: ["A", "B", "C", "D", "E"])
    kmm.trainCenters(points, convergeDistance: 0.01)
    for c in kmm.centroids {
	print("testLarge_2D(): kmm → \(kmm)")
      print(c)
    }
	print("<<< Exiting testLarge_2D()")
  }

  func testLarge_10D() {
	print(">>> Entering testLarge_10D()")
    let points = genPoints(10000, numDimensions: 10)

	print("testLarge_10D(): points → \(points)")
    print("\nCenters")
    let kmm = KMeans<Int>(labels: [1, 2, 3, 4, 5])
    kmm.trainCenters(points, convergeDistance: 0.01)
    for c in kmm.centroids {
	print("testLarge_10D(): kmm → \(kmm)")
      print(c)
    }
	print("<<< Exiting testLarge_10D()")
  }
}
