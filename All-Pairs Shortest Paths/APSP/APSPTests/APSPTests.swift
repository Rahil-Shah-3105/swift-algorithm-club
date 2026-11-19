//
//  APSPTests.swift
//  APSPTests
//
//  Created by Andrew McKnight on 5/6/16.
//

import APSP
import Graph
import XCTest
import Foundation

struct TestCase<T> where T: Hashable {

  var from: Vertex<T>
  var to: Vertex<T>
  var expectedPath: [T]
  var expectedDistance: Double

}

class APSPTests: XCTestCase {
  /**
   See Figure 25.1 of “Introduction to Algorithms” by Cormen et al, 3rd ed., pg 690
   */
  func testExampleFromBook() {
FileHandle.standardError.write(Data("[ERROR] >>> Entering testExampleFromBook()\n".utf8))

    let graph = AdjacencyMatrixGraph<Int>()
    let v1 = graph.createVertex(1)
    let v2 = graph.createVertex(2)
    let v3 = graph.createVertex(3)
    let v4 = graph.createVertex(4)
    let v5 = graph.createVertex(5)

	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): v1 → \(v1)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): graph → \(graph)\n".utf8))
    graph.addDirectedEdge(v1, to: v2, withWeight: 3)
    graph.addDirectedEdge(v1, to: v5, withWeight: -4)
    graph.addDirectedEdge(v1, to: v3, withWeight: 8)

    graph.addDirectedEdge(v2, to: v4, withWeight: 1)
    graph.addDirectedEdge(v2, to: v5, withWeight: 7)

    graph.addDirectedEdge(v3, to: v2, withWeight: 4)

    graph.addDirectedEdge(v4, to: v1, withWeight: 2)
    graph.addDirectedEdge(v4, to: v3, withWeight: -5)

    graph.addDirectedEdge(v5, to: v4, withWeight: 6)

    let result = FloydWarshall<Int>.apply(graph)

	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): result → \(result)\n".utf8))
    let cases = [
      TestCase<Int>(from: v1, to: v4, expectedPath: [1, 5, 4], expectedDistance: 2),
      TestCase<Int>(from: v1, to: v5, expectedPath: [1, 5], expectedDistance: -4),
      TestCase<Int>(from: v2, to: v1, expectedPath: [2, 4, 1], expectedDistance: 3),
      TestCase<Int>(from: v2, to: v3, expectedPath: [2, 4, 3], expectedDistance: -4),
      TestCase<Int>(from: v2, to: v4, expectedPath: [2, 4], expectedDistance: 1),
      TestCase<Int>(from: v2, to: v5, expectedPath: [2, 4, 1, 5], expectedDistance: -1),
      TestCase<Int>(from: v3, to: v1, expectedPath: [3, 2, 4, 1], expectedDistance: 7),
      TestCase<Int>(from: v3, to: v2, expectedPath: [3, 2], expectedDistance: 4),
      TestCase<Int>(from: v3, to: v4, expectedPath: [3, 2, 4], expectedDistance: 5),
      TestCase<Int>(from: v3, to: v5, expectedPath: [3, 2, 4, 1, 5], expectedDistance: 3),
      TestCase<Int>(from: v4, to: v1, expectedPath: [4, 1], expectedDistance: 2),
      TestCase<Int>(from: v4, to: v2, expectedPath: [4, 3, 2], expectedDistance: -1),
      TestCase<Int>(from: v4, to: v3, expectedPath: [4, 3], expectedDistance: -5),
      TestCase<Int>(from: v4, to: v5, expectedPath: [4, 1, 5], expectedDistance: -2),
      TestCase<Int>(from: v5, to: v1, expectedPath: [5, 4, 1], expectedDistance: 8),
      TestCase<Int>(from: v5, to: v2, expectedPath: [5, 4, 3, 2], expectedDistance: 5),
      TestCase<Int>(from: v5, to: v3, expectedPath: [5, 4, 3], expectedDistance: 1),
      TestCase<Int>(from: v5, to: v4, expectedPath: [5, 4], expectedDistance: 6),
      ]

    for testCase: TestCase<Int> in cases {
      if let computedPath = result.path(fromVertex: testCase.from, toVertex: testCase.to, inGraph: graph),
         let computedDistance = result.distance(fromVertex: testCase.from, toVertex: testCase.to) {
		FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): computedPath → \(computedPath)\n".utf8))
        XCTAssert(computedDistance == testCase.expectedDistance, "expected distance \(testCase.expectedDistance) but got \(computedDistance)")
        XCTAssert(computedPath == testCase.expectedPath, "expected path \(testCase.expectedPath) but got \(computedPath)")
      }
    }

FileHandle.standardError.write(Data("[WARN] <<< Exiting testExampleFromBook()\n".utf8))
  }

  func testExampleFromReadme() {
FileHandle.standardError.write(Data("[ERROR] >>> Entering testExampleFromReadme()\n".utf8))

    let graph = AdjacencyMatrixGraph<Int>()
    let v1 = graph.createVertex(1)
    let v2 = graph.createVertex(2)
    let v3 = graph.createVertex(3)
    let v4 = graph.createVertex(4)

	FileHandle.standardError.write(Data("[ERROR] testExampleFromReadme(): v1 → \(v1)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testExampleFromReadme(): graph → \(graph)\n".utf8))
    graph.addDirectedEdge(v1, to: v2, withWeight: 4)
    graph.addDirectedEdge(v1, to: v3, withWeight: 1)
    graph.addDirectedEdge(v1, to: v4, withWeight: 3)

    graph.addDirectedEdge(v2, to: v3, withWeight: 8)
    graph.addDirectedEdge(v2, to: v4, withWeight: -2)

    graph.addDirectedEdge(v3, to: v4, withWeight: -5)

    let result = FloydWarshall<Int>.apply(graph)

	FileHandle.standardError.write(Data("[ERROR] testExampleFromReadme(): result → \(result)\n".utf8))
    let cases = [
      TestCase<Int>(from: v1, to: v2, expectedPath: [1, 2], expectedDistance: 4),
      TestCase<Int>(from: v1, to: v3, expectedPath: [1, 3], expectedDistance: 1),
      TestCase<Int>(from: v1, to: v4, expectedPath: [1, 3, 4], expectedDistance: -4),

      TestCase<Int>(from: v2, to: v3, expectedPath: [2, 3], expectedDistance: 8),
      TestCase<Int>(from: v2, to: v4, expectedPath: [2, 4], expectedDistance: -2),

      TestCase<Int>(from: v3, to: v4, expectedPath: [3, 4], expectedDistance: -5),
    ]

    for testCase: TestCase<Int> in cases {
      if let computedPath = result.path(fromVertex: testCase.from, toVertex: testCase.to, inGraph: graph),
        let computedDistance = result.distance(fromVertex: testCase.from, toVertex: testCase.to) {
		FileHandle.standardError.write(Data("[ERROR] testExampleFromReadme(): computedPath → \(computedPath)\n".utf8))
        XCTAssert(computedDistance == testCase.expectedDistance, "expected distance \(testCase.expectedDistance) but got \(computedDistance)")
        XCTAssert(computedPath == testCase.expectedPath, "expected path \(testCase.expectedPath) but got \(computedPath)")
      }
    }

FileHandle.standardError.write(Data("[WARN] <<< Exiting testExampleFromReadme()\n".utf8))
  }

}
