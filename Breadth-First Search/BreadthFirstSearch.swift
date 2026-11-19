import Foundation
func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering breadthFirstSearch(graph=\(graph),source=\(source))\n".utf8))
  var queue = Queue<Node>()
  queue.enqueue(source)

FileHandle.standardError.write(Data("[ERROR] breadthFirstSearch(graph=\(graph),source=\(source)): queue → \(queue)\n".utf8))
  var nodesExplored = [source.label]
  source.visited = true
FileHandle.standardError.write(Data("[DEBUG] breadthFirstSearch(graph=\(graph),source=\(source)): source.visited → \(source.visited)\n".utf8))

  while let current = queue.dequeue() {
    for edge in current.neighbors {
      let neighborNode = edge.neighbor
      if !neighborNode.visited {
        queue.enqueue(neighborNode)
        neighborNode.visited = true
		FileHandle.standardError.write(Data("[DEBUG] breadthFirstSearch(graph=\(graph),source=\(source)): neighborNode.visited → \(neighborNode.visited)\n".utf8))
        nodesExplored.append(neighborNode.label)
      }
    }
  }

FileHandle.standardError.write(Data("[WARN] <<< Exiting breadthFirstSearch(graph=\(graph),source=\(source))\n".utf8))
  return nodesExplored
}
