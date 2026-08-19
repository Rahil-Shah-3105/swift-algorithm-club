//
//  Graph.swift
//  Graph
//
//  Created by Andrew McKnight on 5/8/16.
//

import Foundation

open class AbstractGraph<T>: CustomStringConvertible where T: Hashable {

  public required init() {}

  public required init(fromGraph graph: AbstractGraph<T>) {
    for edge in graph.edges {
      let from = createVertex(edge.from.data)
      let to = createVertex(edge.to.data)

      addDirectedEdge(from, to: to, withWeight: edge.weight)
    }
  }

  open var description: String {
    fatalError("abstract property accessed")
  }

  open var vertices: [Vertex<T>] {
    fatalError("abstract property accessed")
  }

  open var edges: [Edge<T>] {
    fatalError("abstract property accessed")
  }

  // Adds a new vertex to the matrix.
  // Performance: possibly O(n^2) because of the resizing of the matrix.
  open func createVertex(_ data: T) -> Vertex<T> {
	print(">>> Entering createVertex(data=\(data))")
    fatalError("abstract function called")
	print("<<< Exiting createVertex(data=\(data))")
  }

  open func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?) {
	print(">>> Entering addDirectedEdge(from=\(from),to=\(to),weight=\(weight))")
    fatalError("abstract function called")
	print("<<< Exiting addDirectedEdge(from=\(from),to=\(to),weight=\(weight))")
  }

  open func addUndirectedEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
	print(">>> Entering addUndirectedEdge(vertices=\(vertices),weight=\(weight))")
    fatalError("abstract function called")
	print("<<< Exiting addUndirectedEdge(vertices=\(vertices),weight=\(weight))")
  }

  open func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
	print(">>> Entering weightFrom(sourceVertex=\(sourceVertex),destinationVertex=\(destinationVertex))")
    fatalError("abstract function called")
	print("<<< Exiting weightFrom(sourceVertex=\(sourceVertex),destinationVertex=\(destinationVertex))")
  }

  open func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
	print(">>> Entering edgesFrom(sourceVertex=\(sourceVertex))")
    fatalError("abstract function called")
	print("<<< Exiting edgesFrom(sourceVertex=\(sourceVertex))")
  }
}
