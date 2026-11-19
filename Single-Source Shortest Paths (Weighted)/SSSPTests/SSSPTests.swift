//
//  SSSPTests.swift
//  SSSPTests
//
//  Created by Andrew McKnight on 5/8/16.
//

import Graph
import XCTest
@testable import SSSP
import Foundation

class SSSPTests: XCTestCase {
  
  func testSwift4() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testSwift4()\n".utf8))
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testSwift4()\n".utf8))
  }

  /**
   See Figure 24.4 of “Introduction to Algorithms” by Cormen et al, 3rd ed., pg 652
   */
  func testExampleFromBook() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testExampleFromBook()\n".utf8))
    let graph = AdjacencyMatrixGraph<String>()
    let s = graph.createVertex("s")
    let t = graph.createVertex("t")
    let x = graph.createVertex("x")
    let y = graph.createVertex("y")
    let z = graph.createVertex("z")

	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): graph → \(graph)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): s → \(s)\n".utf8))
    graph.addDirectedEdge(s, to: t, withWeight: 6)
    graph.addDirectedEdge(s, to: y, withWeight: 7)

    graph.addDirectedEdge(t, to: x, withWeight: 5)
    graph.addDirectedEdge(t, to: y, withWeight: 8)
    graph.addDirectedEdge(t, to: z, withWeight: -4)

    graph.addDirectedEdge(x, to: t, withWeight: -2)

    graph.addDirectedEdge(y, to: x, withWeight: -3)
    graph.addDirectedEdge(y, to: z, withWeight: 9)

    graph.addDirectedEdge(z, to: s, withWeight: 2)
    graph.addDirectedEdge(z, to: x, withWeight: 7)

    let result = BellmanFord<String>.apply(graph, source: s)!
	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): result → \(result)\n".utf8))

    let expectedPath = ["s", "y", "x", "t", "z"]
	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): expectedPath → \(expectedPath)\n".utf8))
    let computedPath = result.path(to: z, inGraph: graph)!
	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): computedPath → \(computedPath)\n".utf8))
    XCTAssertEqual(expectedPath, computedPath, "expected path of \(expectedPath) but got \(computedPath)")

    let expectedWeight = -2.0
    let computedWeight = result.distance(to: z)
    XCTAssertEqual(expectedWeight, computedWeight, "expected weight of \(expectedWeight) but got \(computedWeight)")
	FileHandle.standardError.write(Data("[ERROR] testExampleFromBook(): computedWeight → \(computedWeight)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testExampleFromBook()\n".utf8))
  }

  func testSimpleExample() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testSimpleExample()\n".utf8))
    let graph = AdjacencyMatrixGraph<String>()
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let c = graph.createVertex("c")
    let d = graph.createVertex("d")
    let e = graph.createVertex("e")

	FileHandle.standardError.write(Data("[ERROR] testSimpleExample(): graph → \(graph)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testSimpleExample(): a → \(a)\n".utf8))
    graph.addDirectedEdge(a, to: b, withWeight: 4)
    graph.addDirectedEdge(a, to: c, withWeight: 5)
    graph.addDirectedEdge(a, to: d, withWeight: 8)

    graph.addDirectedEdge(b, to: c, withWeight: -2)

    graph.addDirectedEdge(c, to: e, withWeight: 4)

    graph.addDirectedEdge(d, to: e, withWeight: 2)

    graph.addDirectedEdge(e, to: d, withWeight: 1)

    let result = BellmanFord<String>.apply(graph, source: a)!
	FileHandle.standardError.write(Data("[ERROR] testSimpleExample(): result → \(result)\n".utf8))

    let expectedPath = ["a", "b", "c", "e", "d"]
	FileHandle.standardError.write(Data("[ERROR] testSimpleExample(): expectedPath → \(expectedPath)\n".utf8))
    let computedPath = result.path(to: d, inGraph: graph)!
	FileHandle.standardError.write(Data("[ERROR] testSimpleExample(): computedPath → \(computedPath)\n".utf8))
    XCTAssertEqual(expectedPath, computedPath, "expected path of \(expectedPath) but got \(computedPath)")

    let expectedWeight = 7.0
    let computedWeight = result.distance(to: d)
    XCTAssertEqual(expectedWeight, computedWeight, "expected weight of \(expectedWeight) but got \(computedWeight)")
	FileHandle.standardError.write(Data("[ERROR] testSimpleExample(): computedWeight → \(computedWeight)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testSimpleExample()\n".utf8))
  }

  /**
   Construct a nearly bipartite graph, except one vertex only has out-edges. Then no path should exist from the source to that vertex.
   */
  func testGraphWithUnreachableVertex() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testGraphWithUnreachableVertex()\n".utf8))
    let graph = AdjacencyMatrixGraph<String>()
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let s = graph.createVertex("s")
    let t = graph.createVertex("t")

	FileHandle.standardError.write(Data("[ERROR] testGraphWithUnreachableVertex(): graph → \(graph)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testGraphWithUnreachableVertex(): a → \(a)\n".utf8))
    graph.addDirectedEdge(a, to: s, withWeight: 9)
    graph.addDirectedEdge(a, to: t, withWeight: 2)

    graph.addDirectedEdge(b, to: a, withWeight: 1)
    graph.addDirectedEdge(b, to: s, withWeight: 2)
    graph.addDirectedEdge(b, to: t, withWeight: 3)

    graph.addDirectedEdge(s, to: a, withWeight: 4)
    graph.addDirectedEdge(s, to: t, withWeight: 1)

    graph.addDirectedEdge(t, to: a, withWeight: 7)
    graph.addDirectedEdge(t, to: s, withWeight: 5)

    let result = BellmanFord<String>.apply(graph, source: a)!
	FileHandle.standardError.write(Data("[ERROR] testGraphWithUnreachableVertex(): result → \(result)\n".utf8))

    XCTAssertNil(result.path(to: b, inGraph: graph), "a path should not be defined from a ~> b")
    XCTAssertNil(result.distance(to: b), "a path should not be defined from a ~> b")
    XCTAssertNotNil(result.path(to: s, inGraph: graph), "a path should be defined from a ~> s")
    XCTAssertNotNil(result.distance(to: s), "a path should be defined from a ~> s")
    XCTAssertNotNil(result.path(to: t, inGraph: graph), "a path should be defined from a ~> t")
    XCTAssertNotNil(result.distance(to: t), "a path should be defined from a ~> t")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testGraphWithUnreachableVertex()\n".utf8))
  }

  func testNegativeWeightCycle() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testNegativeWeightCycle()\n".utf8))
    let graph = AdjacencyMatrixGraph<String>()
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let s = graph.createVertex("s")
    let t = graph.createVertex("t")

	FileHandle.standardError.write(Data("[ERROR] testNegativeWeightCycle(): graph → \(graph)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testNegativeWeightCycle(): a → \(a)\n".utf8))
    graph.addDirectedEdge(a, to: t, withWeight: 2)

    graph.addDirectedEdge(b, to: t, withWeight: 5)

    graph.addDirectedEdge(s, to: a, withWeight: 4)
    graph.addDirectedEdge(s, to: b, withWeight: 4)

    graph.addDirectedEdge(t, to: s, withWeight: -15)

    XCTAssertNil(BellmanFord<String>.apply(graph, source: s), "negative weight cycle not reported")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testNegativeWeightCycle()\n".utf8))
  }

}
