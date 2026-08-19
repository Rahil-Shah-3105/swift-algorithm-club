//
//  GraphTests.swift
//  GraphTests
//
//  Created by Andrew McKnight on 5/8/16.
//

import XCTest
@testable import Graph

class GraphTests: XCTestCase {

  func testAdjacencyMatrixGraphDescription() {
print(">>> Entering testAdjacencyMatrixGraphDescription()")

    let graph = AdjacencyMatrixGraph<String>()

	print("testAdjacencyMatrixGraphDescription(): graph → \(graph)")
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let c = graph.createVertex("c")

	print("testAdjacencyMatrixGraphDescription(): a → \(a)")
	print("testAdjacencyMatrixGraphDescription(): b → \(b)")
	print("testAdjacencyMatrixGraphDescription(): c → \(c)")
    graph.addDirectedEdge(a, to: b, withWeight: 1.0)
    graph.addDirectedEdge(b, to: c, withWeight: 2.0)

    let expectedValue = "  ø   1.0   ø  \n  ø    ø   2.0 \n  ø    ø    ø  "
	print("testAdjacencyMatrixGraphDescription(): expectedValue → \(expectedValue)")
    XCTAssertEqual(graph.description, expectedValue)
	print("<<< Exiting testAdjacencyMatrixGraphDescription()")
  }

  func testAdjacencyListGraphDescription() {
print(">>> Entering testAdjacencyListGraphDescription()")

    let graph = AdjacencyListGraph<String>()

	print("testAdjacencyListGraphDescription(): graph → \(graph)")
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let c = graph.createVertex("c")

	print("testAdjacencyListGraphDescription(): a → \(a)")
	print("testAdjacencyListGraphDescription(): b → \(b)")
	print("testAdjacencyListGraphDescription(): c → \(c)")
    graph.addDirectedEdge(a, to: b, withWeight: 1.0)
    graph.addDirectedEdge(b, to: c, withWeight: 2.0)
    graph.addDirectedEdge(a, to: c, withWeight: -5.5)

    let expectedValue = "a -> [(b: 1.0), (c: -5.5)]\nb -> [(c: 2.0)]"
	print("testAdjacencyListGraphDescription(): expectedValue → \(expectedValue)")
    XCTAssertEqual(graph.description, expectedValue)
	print("<<< Exiting testAdjacencyListGraphDescription()")
  }

  func testAddingPreexistingVertex() {
	print(">>> Entering testAddingPreexistingVertex()")
    let adjacencyList = AdjacencyListGraph<String>()
    let adjacencyMatrix = AdjacencyMatrixGraph<String>()

	print("testAddingPreexistingVertex(): adjacencyMatrix → \(adjacencyMatrix)")
	print("testAddingPreexistingVertex(): adjacencyList → \(adjacencyList)")
    for graph in [adjacencyList, adjacencyMatrix] {
      let a = graph.createVertex("a")
      let b = graph.createVertex("a")

	print("testAddingPreexistingVertex(): a → \(a)")
	print("testAddingPreexistingVertex(): b → \(b)")
      XCTAssertEqual(a, b, "Should have returned the same vertex when creating a new one with identical data")
      XCTAssertEqual(graph.vertices.count, 1, "Graph should only contain one vertex after trying to create two vertices with identical data")
    }
	print("<<< Exiting testAddingPreexistingVertex()")
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	print(">>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType))")
    let graph = graphType.init()

	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): graph → \(graph)")
	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): a → \(a)")
	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): b → \(b)")
    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

    graph.addDirectedEdge(a, to: b, withWeight: 1.0)

    let edgesFromA = graph.edgesFrom(a)
    let edgesFromB = graph.edgesFrom(b)

	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): edgesFromA → \(edgesFromA)")
	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): edgesFromB → \(edgesFromB)")
    XCTAssertEqual(edgesFromA.count, 1)
    XCTAssertEqual(edgesFromB.count, 0)

    XCTAssertEqual(edgesFromA.first?.to, b)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType))")
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	print(">>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType))")
    let graph = graphType.init()

	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): graph → \(graph)")
	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): a → \(a)")
	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): b → \(b)")
    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

    graph.addUndirectedEdge((a, b), withWeight: 1.0)

    let edgesFromA = graph.edgesFrom(a)
    let edgesFromB = graph.edgesFrom(b)

	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): edgesFromA → \(edgesFromA)")
	print("testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): edgesFromB → \(edgesFromB)")
    XCTAssertEqual(edgesFromA.count, 1)
    XCTAssertEqual(edgesFromB.count, 1)

    XCTAssertEqual(edgesFromA.first?.to, b)
    XCTAssertEqual(edgesFromB.first?.to, a)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType))")
  }

  func testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	print(">>> Entering testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType))")
    let graph = graphType.init()

	print("testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType)): graph → \(graph)")
	print("testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType)): a → \(a)")
	print("testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType)): b → \(b)")
    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

    XCTAssertEqual(graph.edgesFrom(a).count, 0)
    XCTAssertEqual(graph.edgesFrom(b).count, 0)
	print("<<< Exiting testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType))")
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	print(">>> Entering testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType))")
    let graph = graphType.init()
    let verticesCount = 100
	print("testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType)): graph → \(graph)")
    var vertices: [Vertex<Int>] = []

    for i in 0..<verticesCount {
      vertices.append(graph.createVertex(i))
    }

    for i in 0..<verticesCount {
      for j in i+1..<verticesCount {
        graph.addDirectedEdge(vertices[i], to: vertices[j], withWeight: 1)
      }
    }

    for i in 0..<verticesCount {
      let outEdges = graph.edgesFrom(vertices[i])
      let toVertices = outEdges.map {return $0.to}
	print("testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType)): outEdges → \(outEdges)")
      XCTAssertEqual(outEdges.count, verticesCount - i - 1)
      for j in i+1..<verticesCount {
        XCTAssertTrue(toVertices.contains(vertices[j]))
      }
    }
	print("<<< Exiting testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType))")
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedMatrixGraph() {
	print(">>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedMatrixGraph()")
    testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(AdjacencyMatrixGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedMatrixGraph()")
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedMatrixGraph() {
	print(">>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedMatrixGraph()")
    testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(AdjacencyMatrixGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedMatrixGraph()")
  }

  func testEdgesFromReturnsNoInNoEdgeMatrixGraph() {
	print(">>> Entering testEdgesFromReturnsNoInNoEdgeMatrixGraph()")
    testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(AdjacencyMatrixGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsNoInNoEdgeMatrixGraph()")
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedMatrixGraph() {
	print(">>> Entering testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedMatrixGraph()")
    testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(AdjacencyMatrixGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedMatrixGraph()")
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedListGraph() {
	print(">>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedListGraph()")
    testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(AdjacencyListGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedListGraph()")
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedListGraph() {
	print(">>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedListGraph()")
    testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(AdjacencyListGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedListGraph()")
  }

  func testEdgesFromReturnsNoInNoEdgeListGraph() {
	print(">>> Entering testEdgesFromReturnsNoInNoEdgeListGraph()")
    testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(AdjacencyListGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsNoInNoEdgeListGraph()")
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedListGraph() {
	print(">>> Entering testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedListGraph()")
    testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(AdjacencyListGraph<Int>.self)
	print("<<< Exiting testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedListGraph()")
  }
}
