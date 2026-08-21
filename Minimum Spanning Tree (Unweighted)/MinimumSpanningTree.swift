func breadthFirstSearchMinimumSpanningTree(_ graph: Graph, source: Node) -> Graph {
print(">>> Entering breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source))")
  let minimumSpanningTree = graph.duplicate()

print("breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): minimumSpanningTree → \(minimumSpanningTree)")
print("breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): queue → \(queue)")
print("breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): sourceInMinimumSpanningTree → \(sourceInMinimumSpanningTree)")
  var queue = Queue<Node>()
  let sourceInMinimumSpanningTree = minimumSpanningTree.findNodeWithLabel(source.label)
  queue.enqueue(sourceInMinimumSpanningTree)
  sourceInMinimumSpanningTree.visited = true
print("breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): sourceInMinimumSpanningTree.visited → \(sourceInMinimumSpanningTree.visited)")

  while let current = queue.dequeue() {
	print("breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): current → \(current)")
    for edge in current.neighbors {
      let neighborNode = edge.neighbor
      if !neighborNode.visited {
        neighborNode.visited = true
		print("breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): neighborNode.visited → \(neighborNode.visited)")
        queue.enqueue(neighborNode)
      } else {
        current.remove(edge)
      }
    }
  }

print("<<< Exiting breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source))")
  return minimumSpanningTree
}
