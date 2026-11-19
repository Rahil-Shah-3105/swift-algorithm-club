import Foundation
// last checked with Xcode 10.1

func depthFirstSearch(_ graph: Graph, source: Node) -> [String] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering depthFirstSearch(graph=\(graph),source=\(source))\n".utf8))
    var nodesExplored = [source.label]
    source.visited = true
	FileHandle.standardError.write(Data("[DEBUG] depthFirstSearch(graph=\(graph),source=\(source)): source.visited → \(source.visited)\n".utf8))
    
    for edge in source.neighbors {
        if !edge.neighbor.visited {
            nodesExplored += depthFirstSearch(graph, source: edge.neighbor)
        }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting depthFirstSearch(graph=\(graph),source=\(source))\n".utf8))
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

let nodesExplored = depthFirstSearch(graph, source: nodeA)
print(nodesExplored)
