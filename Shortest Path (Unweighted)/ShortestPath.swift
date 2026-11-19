import Foundation
func breadthFirstSearchShortestPath(graph: Graph, source: Node) -> Graph {
FileHandle.standardError.write(Data("[ERROR] >>> Entering breadthFirstSearchShortestPath(graph=\(graph),source=\(source))\n".utf8))
  let shortestPathGraph = graph.duplicate()

FileHandle.standardError.write(Data("[ERROR] breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): shortestPathGraph → \(shortestPathGraph)\n".utf8))
  var queue = Queue<Node>()
  let sourceInShortestPathsGraph = shortestPathGraph.findNodeWithLabel(label: source.label)
  queue.enqueue(element: sourceInShortestPathsGraph)
  sourceInShortestPathsGraph.distance = 0
FileHandle.standardError.write(Data("[DEBUG] breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): sourceInShortestPathsGraph.distance → \(sourceInShortestPathsGraph.distance)\n".utf8))
FileHandle.standardError.write(Data("[ERROR] breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): queue → \(queue)\n".utf8))

  while let current = queue.dequeue() {
    for edge in current.neighbors {
      let neighborNode = edge.neighbor
      if !neighborNode.hasDistance {
        queue.enqueue(element: neighborNode)
        neighborNode.distance = current.distance! + 1
		FileHandle.standardError.write(Data("[DEBUG] breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): neighborNode.distance → \(neighborNode.distance)\n".utf8))
      }
    }
  }

FileHandle.standardError.write(Data("[WARN] <<< Exiting breadthFirstSearchShortestPath(graph=\(graph),source=\(source))\n".utf8))
  return shortestPathGraph
}
