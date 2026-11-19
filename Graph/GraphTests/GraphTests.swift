//
//  GraphTests.swift
//  GraphTests
//
//  Created by Andrew McKnight on 5/8/16.
//

import XCTest
@testable import Graph
import Foundation

class GraphTests: XCTestCase {

  func testAdjacencyMatrixGraphDescription() {
FileHandle.standardError.write(Data("[ERROR] >>> Entering testAdjacencyMatrixGraphDescription()\n".utf8))

    let graph = AdjacencyMatrixGraph<String>()

	FileHandle.standardError.write(Data("[ERROR] testAdjacencyMatrixGraphDescription(): graph → \(graph)\n".utf8))
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let c = graph.createVertex("c")

	FileHandle.standardError.write(Data("[ERROR] testAdjacencyMatrixGraphDescription(): a → \(a)\n".utf8))
    graph.addDirectedEdge(a, to: b, withWeight: 1.0)
    graph.addDirectedEdge(b, to: c, withWeight: 2.0)

    let expectedValue = "  ø   1.0   ø  \n  ø    ø   2.0 \n  ø    ø    ø  "
	FileHandle.standardError.write(Data("[ERROR] testAdjacencyMatrixGraphDescription(): expectedValue → \(expectedValue)\n".utf8))
    XCTAssertEqual(graph.description, expectedValue)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testAdjacencyMatrixGraphDescription()\n".utf8))
  }

  func testAdjacencyListGraphDescription() {
FileHandle.standardError.write(Data("[ERROR] >>> Entering testAdjacencyListGraphDescription()\n".utf8))

    let graph = AdjacencyListGraph<String>()

	FileHandle.standardError.write(Data("[ERROR] testAdjacencyListGraphDescription(): graph → \(graph)\n".utf8))
    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let c = graph.createVertex("c")

	FileHandle.standardError.write(Data("[ERROR] testAdjacencyListGraphDescription(): a → \(a)\n".utf8))
    graph.addDirectedEdge(a, to: b, withWeight: 1.0)
    graph.addDirectedEdge(b, to: c, withWeight: 2.0)
    graph.addDirectedEdge(a, to: c, withWeight: -5.5)

    let expectedValue = "a -> [(b: 1.0), (c: -5.5)]\nb -> [(c: 2.0)]"
	FileHandle.standardError.write(Data("[ERROR] testAdjacencyListGraphDescription(): expectedValue → \(expectedValue)\n".utf8))
    XCTAssertEqual(graph.description, expectedValue)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testAdjacencyListGraphDescription()\n".utf8))
  }

  func testAddingPreexistingVertex() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testAddingPreexistingVertex()\n".utf8))
    let adjacencyList = AdjacencyListGraph<String>()
    let adjacencyMatrix = AdjacencyMatrixGraph<String>()

	FileHandle.standardError.write(Data("[ERROR] testAddingPreexistingVertex(): adjacencyMatrix → \(adjacencyMatrix)\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testAddingPreexistingVertex(): adjacencyList → \(adjacencyList)\n".utf8))
    for graph in [adjacencyList, adjacencyMatrix] {
      let a = graph.createVertex("a")
      let b = graph.createVertex("a")

	FileHandle.standardError.write(Data("[ERROR] testAddingPreexistingVertex(): a → \(a)\n".utf8))
      XCTAssertEqual(a, b, "Should have returned the same vertex when creating a new one with identical data")
      XCTAssertEqual(graph.vertices.count, 1, "Graph should only contain one vertex after trying to create two vertices with identical data")
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testAddingPreexistingVertex()\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType))\n".utf8))
    let graph = graphType.init()

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): graph → \(graph)\n".utf8))
    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): a → \(a)\n".utf8))
    graph.addDirectedEdge(a, to: b, withWeight: 1.0)

    let edgesFromA = graph.edgesFrom(a)
    let edgesFromB = graph.edgesFrom(b)

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType)): edgesFromA → \(edgesFromA)\n".utf8))
    XCTAssertEqual(edgesFromA.count, 1)
    XCTAssertEqual(edgesFromB.count, 0)

    XCTAssertEqual(edgesFromA.first?.to, b)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(graphType=\(graphType))\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType))\n".utf8))
    let graph = graphType.init()

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): graph → \(graph)\n".utf8))
    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): a → \(a)\n".utf8))
    graph.addUndirectedEdge((a, b), withWeight: 1.0)

    let edgesFromA = graph.edgesFrom(a)
    let edgesFromB = graph.edgesFrom(b)

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType)): edgesFromA → \(edgesFromA)\n".utf8))
    XCTAssertEqual(edgesFromA.count, 1)
    XCTAssertEqual(edgesFromB.count, 1)

    XCTAssertEqual(edgesFromA.first?.to, b)
    XCTAssertEqual(edgesFromB.first?.to, a)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(graphType=\(graphType))\n".utf8))
  }

  func testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType))\n".utf8))
    let graph = graphType.init()

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType)): graph → \(graph)\n".utf8))
    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType)): a → \(a)\n".utf8))
    XCTAssertEqual(graph.edgesFrom(a).count, 0)
    XCTAssertEqual(graph.edgesFrom(b).count, 0)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(graphType=\(graphType))\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType))\n".utf8))
    let graph = graphType.init()
    let verticesCount = 100
	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType)): graph → \(graph)\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType)): outEdges → \(outEdges)\n".utf8))
      XCTAssertEqual(outEdges.count, verticesCount - i - 1)
      for j in i+1..<verticesCount {
        XCTAssertTrue(toVertices.contains(vertices[j]))
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(graphType=\(graphType))\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedMatrixGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedMatrixGraph()\n".utf8))
    testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(AdjacencyMatrixGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedMatrixGraph()\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedMatrixGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedMatrixGraph()\n".utf8))
    testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(AdjacencyMatrixGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedMatrixGraph()\n".utf8))
  }

  func testEdgesFromReturnsNoInNoEdgeMatrixGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsNoInNoEdgeMatrixGraph()\n".utf8))
    testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(AdjacencyMatrixGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsNoInNoEdgeMatrixGraph()\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedMatrixGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedMatrixGraph()\n".utf8))
    testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(AdjacencyMatrixGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedMatrixGraph()\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedListGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedListGraph()\n".utf8))
    testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(AdjacencyListGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedListGraph()\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedListGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedListGraph()\n".utf8))
    testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(AdjacencyListGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedListGraph()\n".utf8))
  }

  func testEdgesFromReturnsNoInNoEdgeListGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsNoInNoEdgeListGraph()\n".utf8))
    testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(AdjacencyListGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsNoInNoEdgeListGraph()\n".utf8))
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedListGraph() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedListGraph()\n".utf8))
    testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(AdjacencyListGraph<Int>.self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedListGraph()\n".utf8))
  }
}
