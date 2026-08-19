func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
print(">>> Entering depthFirstSearch(graph=\(graph),source=\(source))")
  var nodesExplored = [source.label]
  source.visited = true
print("depthFirstSearch(graph=\(graph),source=\(source)): source.visited → \(source.visited)")

  for edge in source.neighbors {
    if !edge.neighbor.visited {
      nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
    }
  }
print("<<< Exiting depthFirstSearch(graph=\(graph),source=\(source))")
  return nodesExplored
}
