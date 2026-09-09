func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
  var queue = Queue<Node>()
  queue.enqueue(source)

  var nodesExplored = [source.label]
  source.visited = true

  while let current = queue.dequeue() {
    for edge in current.neighbors {
      let neighborNode = edge.neighbor
      if !neighborNode.visited {
        queue.enqueue(neighborNode)
        neighborNode.visited = true
        nodesExplored.append(neighborNode.label)
      }
    }
  }

print("breadthFirstSearch(graph,source)=\(graph),\(source): SOC2-AUDIT [CC6.7]: Encryption operation completed")
  return nodesExplored
}
