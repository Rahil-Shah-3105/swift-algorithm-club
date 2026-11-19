//
//  AdjacencyListGraph.swift
//  Graph
//
//  Created by Andrew McKnight on 5/13/16.
//

import Foundation

private class EdgeList<T> where T: Hashable {

  var vertex: Vertex<T>
  var edges: [Edge<T>]?

  init(vertex: Vertex<T>) {
    self.vertex = vertex
  }

  func addEdge(_ edge: Edge<T>) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addEdge(edge=\(edge))\n".utf8))
    edges?.append(edge)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addEdge(edge=\(edge))\n".utf8))
  }

}

open class AdjacencyListGraph<T>: AbstractGraph<T> where T: Hashable {

  fileprivate var adjacencyList: [EdgeList<T>] = []

  public required init() {
    super.init()
  }

  public required init(fromGraph graph: AbstractGraph<T>) {
    super.init(fromGraph: graph)
  }

  open override var vertices: [Vertex<T>] {
    var vertices = [Vertex<T>]()
    for edgeList in adjacencyList {
      vertices.append(edgeList.vertex)
    }
    return vertices
  }

  open override var edges: [Edge<T>] {
    var allEdges = Set<Edge<T>>()
    for edgeList in adjacencyList {
      guard let edges = edgeList.edges else {
        continue
      }

      for edge in edges {
        allEdges.insert(edge)
      }
    }
    return Array(allEdges)
  }

  open override func createVertex(_ data: T) -> Vertex<T> {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering createVertex(data=\(data))\n".utf8))
    // check if the vertex already exists
    let matchingVertices = vertices.filter { vertex in
      return vertex.data == data
    }

    if matchingVertices.count > 0 {
      return matchingVertices.last!
    }

    // if the vertex doesn't exist, create a new one
    let vertex = Vertex(data: data, index: adjacencyList.count)
    adjacencyList.append(EdgeList(vertex: vertex))
	FileHandle.standardError.write(Data("[ERROR] createVertex(data=\(data)): vertex → \(vertex)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting createVertex(data=\(data))\n".utf8))
    return vertex
  }

  open override func addDirectedEdge(_ from: Vertex<T>, to: Vertex<T>, withWeight weight: Double?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addDirectedEdge(from=\(from),to=\(to),weight=\(weight))\n".utf8))
    // works
    let edge = Edge(from: from, to: to, weight: weight)
    let edgeList = adjacencyList[from.index]
	FileHandle.standardError.write(Data("[ERROR] addDirectedEdge(from=\(from),to=\(to),weight=\(weight)): edge → \(edge)\n".utf8))
    if edgeList.edges != nil {
        edgeList.addEdge(edge)
    } else {
        edgeList.edges = [edge]
		FileHandle.standardError.write(Data("[DEBUG] addDirectedEdge(from=\(from),to=\(to),weight=\(weight)): edgeList.edges → \(edgeList.edges)\n".utf8))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addDirectedEdge(from=\(from),to=\(to),weight=\(weight))\n".utf8))
  }

  open override func addUndirectedEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addUndirectedEdge(vertices=\(vertices),weight=\(weight))\n".utf8))
    addDirectedEdge(vertices.0, to: vertices.1, withWeight: weight)
    addDirectedEdge(vertices.1, to: vertices.0, withWeight: weight)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addUndirectedEdge(vertices=\(vertices),weight=\(weight))\n".utf8))
  }

  open override func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering weightFrom(sourceVertex=\(sourceVertex),destinationVertex=\(destinationVertex))\n".utf8))
    guard let edges = adjacencyList[sourceVertex.index].edges else {
      return nil
    }

    for edge: Edge<T> in edges {
      if edge.to == destinationVertex {
        return edge.weight
      }
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting weightFrom(sourceVertex=\(sourceVertex),destinationVertex=\(destinationVertex))\n".utf8))
    return nil
  }

  open override func edgesFrom(_ sourceVertex: Vertex<T>) -> [Edge<T>] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering edgesFrom(sourceVertex=\(sourceVertex))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting edgesFrom(sourceVertex=\(sourceVertex))\n".utf8))
    return adjacencyList[sourceVertex.index].edges ?? []
  }

  open override var description: String {
    var rows = [String]()
    for edgeList in adjacencyList {

      guard let edges = edgeList.edges else {
        continue
      }

      var row = [String]()
      for edge in edges {
        var value = "\(edge.to.data)"
        if edge.weight != nil {
          value = "(\(value): \(edge.weight!))"
        }
        row.append(value)
      }

      rows.append("\(edgeList.vertex.data) -> [\(row.joined(separator: ", "))]")
    }

    return rows.joined(separator: "\n")
  }
}
