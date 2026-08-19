func breadthFirstSearchShortestPath(graph: Graph, source: Node) -> Graph {
print(">>> Entering breadthFirstSearchShortestPath(graph=\(graph),source=\(source))")
  let shortestPathGraph = graph.duplicate()

print("breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): shortestPathGraph → \(shortestPathGraph)")
print("breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): queue → \(queue)")
print("breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): sourceInShortestPathsGraph → \(sourceInShortestPathsGraph)")
  var queue = Queue<Node>()
  let sourceInShortestPathsGraph = shortestPathGraph.findNodeWithLabel(label: source.label)
  queue.enqueue(element: sourceInShortestPathsGraph)
  sourceInShortestPathsGraph.distance = 0
print("breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): sourceInShortestPathsGraph.distance → \(sourceInShortestPathsGraph.distance)")

  while let current = queue.dequeue() {
	print("breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): current → \(current)")
    for edge in current.neighbors {
      let neighborNode = edge.neighbor
      if !neighborNode.hasDistance {
        queue.enqueue(element: neighborNode)
        neighborNode.distance = current.distance! + 1
		print("breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): neighborNode.distance → \(neighborNode.distance)")
      }
    }
  }

print("<<< Exiting breadthFirstSearchShortestPath(graph=\(graph),source=\(source))")
  return shortestPathGraph
}
