import Foundation
//
//  Kruskal.swift
//  
//
//  Created by xiang xin on 16/3/17.
//
//

func minimumSpanningTreeKruskal<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
FileHandle.standardError.write(Data("[ERROR] >>> Entering minimumSpanningTreeKruskal(graph=\(graph))\n".utf8))
  var cost: Int = 0
  var tree = Graph<T>()
  let sortedEdgeListByWeight = graph.edgeList.sorted(by: { $0.weight < $1.weight })
  
FileHandle.standardError.write(Data("[ERROR] minimumSpanningTreeKruskal(graph=\(graph)): tree → \(tree)\n".utf8))
  var unionFind = UnionFind<T>()
  for vertex in graph.vertices {
FileHandle.standardError.write(Data("[ERROR] minimumSpanningTreeKruskal(graph=\(graph)): unionFind → \(unionFind)\n".utf8))
    unionFind.addSetWith(vertex)
  }
  
  for edge in sortedEdgeListByWeight {
    let v1 = edge.vertex1
    let v2 = edge.vertex2
    if !unionFind.inSameSet(v1, and: v2) {
      cost += edge.weight
      tree.addEdge(edge)
      unionFind.unionSetsContaining(v1, and: v2)
    }
  }
  
FileHandle.standardError.write(Data("[WARN] <<< Exiting minimumSpanningTreeKruskal(graph=\(graph))\n".utf8))
  return (cost: cost, tree: tree)
}
