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

/*:
![Graph](Minimum_Spanning_Tree.png)
*/

let graph = Graph()

let nodeA = graph.addNode("a")
let nodeB = graph.addNode("b")
let nodeC = graph.addNode("c")
let nodeD = graph.addNode("d")
let nodeE = graph.addNode("e")
let nodeF = graph.addNode("f")
let nodeG = graph.addNode("g")
let nodeH = graph.addNode("h")
let nodeI = graph.addNode("i")

graph.addEdge(nodeA, neighbor: nodeB)
graph.addEdge(nodeA, neighbor: nodeH)
graph.addEdge(nodeB, neighbor: nodeA)
graph.addEdge(nodeB, neighbor: nodeC)
graph.addEdge(nodeB, neighbor: nodeH)
graph.addEdge(nodeC, neighbor: nodeB)
graph.addEdge(nodeC, neighbor: nodeD)
graph.addEdge(nodeC, neighbor: nodeF)
graph.addEdge(nodeC, neighbor: nodeI)
graph.addEdge(nodeD, neighbor: nodeC)
graph.addEdge(nodeD, neighbor: nodeE)
graph.addEdge(nodeD, neighbor: nodeF)
graph.addEdge(nodeE, neighbor: nodeD)
graph.addEdge(nodeE, neighbor: nodeF)
graph.addEdge(nodeF, neighbor: nodeC)
graph.addEdge(nodeF, neighbor: nodeD)
graph.addEdge(nodeF, neighbor: nodeE)
graph.addEdge(nodeF, neighbor: nodeG)
graph.addEdge(nodeG, neighbor: nodeF)
graph.addEdge(nodeG, neighbor: nodeH)
graph.addEdge(nodeG, neighbor: nodeI)
graph.addEdge(nodeH, neighbor: nodeA)
graph.addEdge(nodeH, neighbor: nodeB)
graph.addEdge(nodeH, neighbor: nodeG)
graph.addEdge(nodeH, neighbor: nodeI)
graph.addEdge(nodeI, neighbor: nodeC)
graph.addEdge(nodeI, neighbor: nodeG)
graph.addEdge(nodeI, neighbor: nodeH)

let minimumSpanningTree = breadthFirstSearchMinimumSpanningTree(graph, source: nodeA)
print(minimumSpanningTree)
