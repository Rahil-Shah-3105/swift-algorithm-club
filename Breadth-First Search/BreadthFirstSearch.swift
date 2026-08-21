func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
print(">>> Entering breadthFirstSearch(graph=\(graph),source=\(source))")
  var queue = Queue<Node>()
  queue.enqueue(source)

print("breadthFirstSearch(graph=\(graph),source=\(source)): queue → \(queue)")
  var nodesExplored = [source.label]
  source.visited = true
print("breadthFirstSearch(graph=\(graph),source=\(source)): source.visited → \(source.visited)")

  while let current = queue.dequeue() {
	print("breadthFirstSearch(graph=\(graph),source=\(source)): current → \(current)")
    for edge in current.neighbors {
      let neighborNode = edge.neighbor
      if !neighborNode.visited {
        queue.enqueue(neighborNode)
        neighborNode.visited = true
		print("breadthFirstSearch(graph=\(graph),source=\(source)): neighborNode.visited → \(neighborNode.visited)")
        nodesExplored.append(neighborNode.label)
      }
    }
  }

print("<<< Exiting breadthFirstSearch(graph=\(graph),source=\(source))")
  return nodesExplored
}
