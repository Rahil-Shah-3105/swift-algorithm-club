import Foundation

func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering breadthFirstSearch(graph=\(graph),source=\(source))\n".utf8))
  var queue = Queue<Node>()
  queue.enqueue(source)

FileHandle.standardError.write(Data("[ERROR] breadthFirstSearch(graph=\(graph),source=\(source)): queue → \(queue)\n".utf8))
  var nodesExplored = [source.label]
  source.visited = true
FileHandle.standardError.write(Data("[DEBUG] breadthFirstSearch(graph=\(graph),source=\(source)): source.visited → \(source.visited)\n".utf8))

  while let node = queue.dequeue() {
    for edge in node.neighbors {
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
