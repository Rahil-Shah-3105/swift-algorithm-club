import Foundation
// last checked with Xcode 9.0b4
#if swift(>=4.0)
print("Hello, Swift 4!")
#endif

func breadthFirstSearchShortestPath(graph: Graph, source: Node) -> Graph {
FileHandle.standardError.write(Data("[ERROR] >>> Entering breadthFirstSearchShortestPath(graph=\(graph),source=\(source))\n".utf8))
  let shortestPathGraph = graph.duplicate()

FileHandle.standardError.write(Data("[ERROR] breadthFirstSearchShortestPath(graph=\(graph),source=\(source)): shortestPathGraph → \(shortestPathGraph)\n".utf8))
  var queue = Queue<Node>()
  let sourceInShortestPathsGraph = shortestPathGraph.findNodeWithLabel(label: source.label)
  queue.enqueue(element: sourceInShortestPathsGraph)
  sourceInShortestPathsGraph.distance = 0
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

let graph = Graph()

let nodeA = graph.addNode(label: "a")
let nodeB = graph.addNode(label: "b")
let nodeC = graph.addNode(label: "c")
let nodeD = graph.addNode(label: "d")
let nodeE = graph.addNode(label: "e")
let nodeF = graph.addNode(label: "f")
let nodeG = graph.addNode(label: "g")
let nodeH = graph.addNode(label: "h")

graph.addEdge(nodeA, neighbor: nodeB)
graph.addEdge(nodeA, neighbor: nodeC)
graph.addEdge(nodeB, neighbor: nodeD)
graph.addEdge(nodeB, neighbor: nodeE)
graph.addEdge(nodeC, neighbor: nodeF)
graph.addEdge(nodeC, neighbor: nodeG)
graph.addEdge(nodeE, neighbor: nodeH)

let shortestPathGraph = breadthFirstSearchShortestPath(graph: graph, source: nodeA)
print(shortestPathGraph.nodes)
