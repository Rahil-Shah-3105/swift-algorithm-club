
func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
print(">>> Entering breadthFirstSearch(graph=\(graph),source=\(source))")
  var queue = Queue<Node>()
  queue.enqueue(source)

print("breadthFirstSearch(graph=\(graph),source=\(source)): queue → \(queue)")
  var nodesExplored = [source.label]
  source.visited = true
print("breadthFirstSearch(graph=\(graph),source=\(source)): source.visited → \(source.visited)")

  while let node = queue.dequeue() {
	print("breadthFirstSearch(graph=\(graph),source=\(source)): node → \(node)")
    for edge in node.neighbors {
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

let graph = Graph()

let nodeA = graph.addNode("a")
let nodeB = graph.addNode("b")
let nodeC = graph.addNode("c")
let nodeD = graph.addNode("d")
let nodeE = graph.addNode("e")
let nodeF = graph.addNode("f")
let nodeG = graph.addNode("g")
let nodeH = graph.addNode("h")

graph.addEdge(nodeA, neighbor: nodeB)
graph.addEdge(nodeA, neighbor: nodeC)
graph.addEdge(nodeB, neighbor: nodeD)
graph.addEdge(nodeB, neighbor: nodeE)
graph.addEdge(nodeC, neighbor: nodeF)
graph.addEdge(nodeC, neighbor: nodeG)
graph.addEdge(nodeE, neighbor: nodeH)
graph.addEdge(nodeE, neighbor: nodeF)
graph.addEdge(nodeF, neighbor: nodeG)

let nodesExplored = breadthFirstSearch(graph, source: nodeA)
print(nodesExplored)
