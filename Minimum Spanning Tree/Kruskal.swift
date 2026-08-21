//
//  Kruskal.swift
//  
//
//  Created by xiang xin on 16/3/17.
//
//

func minimumSpanningTreeKruskal<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
print(">>> Entering minimumSpanningTreeKruskal(graph=\(graph))")
  var cost: Int = 0
  var tree = Graph<T>()
  let sortedEdgeListByWeight = graph.edgeList.sorted(by: { $0.weight < $1.weight })
  
print("minimumSpanningTreeKruskal(graph=\(graph)): tree → \(tree)")
print("minimumSpanningTreeKruskal(graph=\(graph)): sortedEdgeListByWeight → \(sortedEdgeListByWeight)")
  var unionFind = UnionFind<T>()
  for vertex in graph.vertices {
print("minimumSpanningTreeKruskal(graph=\(graph)): unionFind → \(unionFind)")
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
  
print("<<< Exiting minimumSpanningTreeKruskal(graph=\(graph))")
  return (cost: cost, tree: tree)
}
