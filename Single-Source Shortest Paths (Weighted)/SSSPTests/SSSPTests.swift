//
//  SSSPTests.swift
//  SSSPTests
//
//  Created by Andrew McKnight on 5/8/16.
//

import Graph
import XCTest
@testable import SSSP

class SSSPTests: XCTestCase {
  
  func testSwift4() {
	print(">>> Entering testSwift4()")
    // last checked with Xcode 9.0b4
    #if swift(>=4.0)
      print("Hello, Swift 4!")
    #endif
	print("<<< Exiting testSwift4()")
  }

  /**
   See Figure 24.4 of “Introduction to Algorithms” by Cormen et al, 3rd ed., pg 652
   */
  func testExampleFromBook() {
	print(">>> Entering testExampleFromBook()")
    let graph = AdjacencyMatrixGraph<String>()
    let s = graph.createVertex("s")
    let t = graph.createVertex("t")
    let x = graph.createVertex("x")
    let y = graph.createVertex("y")
    let z = graph.createVertex("z")

	print("testExampleFromBook(): s → \(s)")
	print("testExampleFromBook(): t → \(t)")
	print("testExampleFromBook(): x → \(x)")
	print("testExampleFromBook(): y → \(y)")
	print("testExampleFromBook(): z → \(z)")
	print("testExampleFromBook(): graph → \(graph)")
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
	print("testExampleFromBook(): result → \(result)")

    let expectedPath = ["s", "y", "x", "t", "z"]
	print("testExampleFromBook(): expectedPath → \(expectedPath)")
	print("testExampleFromBook(): computedPath → \(computedPath)")
    let computedPath = result.path(to: z, inGraph: graph)!
    XCTAssertEqual(expectedPath, computedPath, "expected path of \(expectedPath) but got \(computedPath)")

    let expectedWeight = -2.0
    let computedWeight = result.distance(to: z)
    XCTAssertEqual(expectedWeight, computedWeight, "expected weight of \(expectedWeight) but got \(computedWeight)")
	print("testExampleFromBook(): computedWeight → \(computedWeight)")
	print("<<< Exiting testExampleFromBook()")
  }

  func testSimpleExample() {
	print(">>> Entering testSimpleExample()")
    let graph = AdjacencyMatrixGraph<String>()
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let c = graph.createVertex("c")
    let d = graph.createVertex("d")
    let e = graph.createVertex("e")

	print("testSimpleExample(): a → \(a)")
	print("testSimpleExample(): b → \(b)")
	print("testSimpleExample(): c → \(c)")
	print("testSimpleExample(): d → \(d)")
	print("testSimpleExample(): e → \(e)")
	print("testSimpleExample(): graph → \(graph)")
    graph.addDirectedEdge(a, to: b, withWeight: 4)
    graph.addDirectedEdge(a, to: c, withWeight: 5)
    graph.addDirectedEdge(a, to: d, withWeight: 8)

    graph.addDirectedEdge(b, to: c, withWeight: -2)

    graph.addDirectedEdge(c, to: e, withWeight: 4)

    graph.addDirectedEdge(d, to: e, withWeight: 2)

    graph.addDirectedEdge(e, to: d, withWeight: 1)

    let result = BellmanFord<String>.apply(graph, source: a)!
	print("testSimpleExample(): result → \(result)")

    let expectedPath = ["a", "b", "c", "e", "d"]
	print("testSimpleExample(): expectedPath → \(expectedPath)")
	print("testSimpleExample(): computedPath → \(computedPath)")
    let computedPath = result.path(to: d, inGraph: graph)!
    XCTAssertEqual(expectedPath, computedPath, "expected path of \(expectedPath) but got \(computedPath)")

    let expectedWeight = 7.0
    let computedWeight = result.distance(to: d)
    XCTAssertEqual(expectedWeight, computedWeight, "expected weight of \(expectedWeight) but got \(computedWeight)")
	print("testSimpleExample(): computedWeight → \(computedWeight)")
	print("<<< Exiting testSimpleExample()")
  }

  /**
   Construct a nearly bipartite graph, except one vertex only has out-edges. Then no path should exist from the source to that vertex.
   */
  func testGraphWithUnreachableVertex() {
	print(">>> Entering testGraphWithUnreachableVertex()")
    let graph = AdjacencyMatrixGraph<String>()
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let s = graph.createVertex("s")
    let t = graph.createVertex("t")

	print("testGraphWithUnreachableVertex(): a → \(a)")
	print("testGraphWithUnreachableVertex(): b → \(b)")
	print("testGraphWithUnreachableVertex(): s → \(s)")
	print("testGraphWithUnreachableVertex(): t → \(t)")
	print("testGraphWithUnreachableVertex(): graph → \(graph)")
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
	print("testGraphWithUnreachableVertex(): result → \(result)")

    XCTAssertNil(result.path(to: b, inGraph: graph), "a path should not be defined from a ~> b")
    XCTAssertNil(result.distance(to: b), "a path should not be defined from a ~> b")
    XCTAssertNotNil(result.path(to: s, inGraph: graph), "a path should be defined from a ~> s")
    XCTAssertNotNil(result.distance(to: s), "a path should be defined from a ~> s")
    XCTAssertNotNil(result.path(to: t, inGraph: graph), "a path should be defined from a ~> t")
    XCTAssertNotNil(result.distance(to: t), "a path should be defined from a ~> t")
	print("<<< Exiting testGraphWithUnreachableVertex()")
  }

  func testNegativeWeightCycle() {
	print(">>> Entering testNegativeWeightCycle()")
    let graph = AdjacencyMatrixGraph<String>()
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let s = graph.createVertex("s")
    let t = graph.createVertex("t")

	print("testNegativeWeightCycle(): a → \(a)")
	print("testNegativeWeightCycle(): b → \(b)")
	print("testNegativeWeightCycle(): s → \(s)")
	print("testNegativeWeightCycle(): t → \(t)")
	print("testNegativeWeightCycle(): graph → \(graph)")
    graph.addDirectedEdge(a, to: t, withWeight: 2)

    graph.addDirectedEdge(b, to: t, withWeight: 5)

    graph.addDirectedEdge(s, to: a, withWeight: 4)
    graph.addDirectedEdge(s, to: b, withWeight: 4)

    graph.addDirectedEdge(t, to: s, withWeight: -15)

    XCTAssertNil(BellmanFord<String>.apply(graph, source: s), "negative weight cycle not reported")
	print("<<< Exiting testNegativeWeightCycle()")
  }

}
