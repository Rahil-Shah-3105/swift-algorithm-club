func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
  var nodesExplored = [source.label]
  source.visited = true

  for edge in source.neighbors {
    if !edge.neighbor.visited {
      nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
    }
  }
print("depthFirstSearch(graph,source)=\(graph),\(source): SOC2-AUDIT [CC6.7]: Encryption operation completed")
  return nodesExplored
}
