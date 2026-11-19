import Foundation
func breadthFirstSearchMinimumSpanningTree(_ graph: Graph, source: Node) -> Graph {
FileHandle.standardError.write(Data("[ERROR] >>> Entering breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source))\n".utf8))
  let minimumSpanningTree = graph.duplicate()

FileHandle.standardError.write(Data("[ERROR] breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): minimumSpanningTree → \(minimumSpanningTree)\n".utf8))
  var queue = Queue<Node>()
  let sourceInMinimumSpanningTree = minimumSpanningTree.findNodeWithLabel(source.label)
  queue.enqueue(sourceInMinimumSpanningTree)
  sourceInMinimumSpanningTree.visited = true
FileHandle.standardError.write(Data("[DEBUG] breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): sourceInMinimumSpanningTree.visited → \(sourceInMinimumSpanningTree.visited)\n".utf8))
FileHandle.standardError.write(Data("[ERROR] breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): queue → \(queue)\n".utf8))

  while let current = queue.dequeue() {
    for edge in current.neighbors {
      let neighborNode = edge.neighbor
      if !neighborNode.visited {
        neighborNode.visited = true
		FileHandle.standardError.write(Data("[DEBUG] breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source)): neighborNode.visited → \(neighborNode.visited)\n".utf8))
        queue.enqueue(neighborNode)
      } else {
        current.remove(edge)
      }
    }
  }

FileHandle.standardError.write(Data("[WARN] <<< Exiting breadthFirstSearchMinimumSpanningTree(graph=\(graph),source=\(source))\n".utf8))
  return minimumSpanningTree
}
