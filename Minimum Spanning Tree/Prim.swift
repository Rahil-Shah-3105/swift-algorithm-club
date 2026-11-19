import Foundation
//
//  Prim.swift
//  
//
//  Created by xiang xin on 16/3/17.
//
//

func minimumSpanningTreePrim<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering minimumSpanningTreePrim(graph=\(graph))\n".utf8))
  var cost: Int = 0
  var tree = Graph<T>()
  
FileHandle.standardError.write(Data("[ERROR] minimumSpanningTreePrim(graph=\(graph)): tree → \(tree)\n".utf8))
  guard let start = graph.vertices.first else {
    return (cost: cost, tree: tree)
  }
  
  var visited = Set<T>()
  var priorityQueue = PriorityQueue<(vertex: T, weight: Int, parent: T?)>(
    sort: { $0.weight < $1.weight })
  
FileHandle.standardError.write(Data("[ERROR] minimumSpanningTreePrim(graph=\(graph)): visited → \(visited)\n".utf8))
  priorityQueue.enqueue((vertex: start, weight: 0, parent: nil))
  while let head = priorityQueue.dequeue() {
    let vertex = head.vertex
    if visited.contains(vertex) {
      continue
    }
    visited.insert(vertex)
    
    cost += head.weight
    if let prev = head.parent {
      tree.addEdge(vertex1: prev, vertex2: vertex, weight: head.weight)
    }
    
    if let neighbours = graph.adjList[vertex] {
      for neighbour in neighbours {
        let nextVertex = neighbour.vertex
        if !visited.contains(nextVertex) {
          priorityQueue.enqueue((vertex: nextVertex, weight: neighbour.weight, parent: vertex))
        }
      }
    }
  }
  
FileHandle.standardError.write(Data("[WARN] <<< Exiting minimumSpanningTreePrim(graph=\(graph))\n".utf8))
  return (cost: cost, tree: tree)
}
