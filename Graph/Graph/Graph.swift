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
	FileHandle.standardError.write(Data("[ERROR] >>> Entering createVertex(data=\(data))\n".utf8))
    fatalError("abstract function called")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting createVertex(data=\(data))\n".utf8))
  }

  open func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addDirectedEdge(from=\(from),to=\(to),weight=\(weight))\n".utf8))
    fatalError("abstract function called")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addDirectedEdge(from=\(from),to=\(to),weight=\(weight))\n".utf8))
  }

  open func addUndirectedEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addUndirectedEdge(vertices=\(vertices),weight=\(weight))\n".utf8))
    fatalError("abstract function called")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addUndirectedEdge(vertices=\(vertices),weight=\(weight))\n".utf8))
  }

  open func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering weightFrom(sourceVertex=\(sourceVertex),destinationVertex=\(destinationVertex))\n".utf8))
    fatalError("abstract function called")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting weightFrom(sourceVertex=\(sourceVertex),destinationVertex=\(destinationVertex))\n".utf8))
  }

  open func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering edgesFrom(sourceVertex=\(sourceVertex))\n".utf8))
    fatalError("abstract function called")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting edgesFrom(sourceVertex=\(sourceVertex))\n".utf8))
  }
}
