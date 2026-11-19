import Foundation
func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering depthFirstSearch(graph=\(graph),source=\(source))\n".utf8))
  var nodesExplored = [source.label]
  source.visited = true
FileHandle.standardError.write(Data("[DEBUG] depthFirstSearch(graph=\(graph),source=\(source)): source.visited → \(source.visited)\n".utf8))

  for edge in source.neighbors {
    if !edge.neighbor.visited {
      nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
    }
  }
FileHandle.standardError.write(Data("[WARN] <<< Exiting depthFirstSearch(graph=\(graph),source=\(source))\n".utf8))
  return nodesExplored
}
