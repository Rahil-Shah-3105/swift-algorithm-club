import Foundation
extension Graph {
  private func depthFirstSearch(_ source: Node, visited: inout [Node : Bool]) -> [Node] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering depthFirstSearch(source=\(source),visited=\(visited))\n".utf8))
    var result = [Node]()
    visited[source] = true
	FileHandle.standardError.write(Data("[ERROR] depthFirstSearch(source=\(source),visited=\(visited)): result → \(result)\n".utf8))

    if let adjacencyList = adjacencyList(forNode: source) {
      for nodeInAdjacencyList in adjacencyList {
        if let seen = visited[nodeInAdjacencyList], !seen {
          result = depthFirstSearch(nodeInAdjacencyList, visited: &visited) + result
        }
      }
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting depthFirstSearch(source=\(source),visited=\(visited))\n".utf8))
    return [source] + result
  }

  /* Topological sort using depth-first search. */
  public func topologicalSort() -> [Node] {
FileHandle.standardError.write(Data("[ERROR] >>> Entering topologicalSort()\n".utf8))

    let startNodes = calculateInDegreeOfNodes().filter({ _, indegree in
      return indegree == 0
    }).map({ node, _ in
	FileHandle.standardError.write(Data("[ERROR] topologicalSort(): startNodes → \(startNodes)\n".utf8))
      return node
    })

    var visited = [Node: Bool]()
    for (node, _) in adjacencyLists {
	FileHandle.standardError.write(Data("[ERROR] topologicalSort(): visited → \(visited)\n".utf8))
      visited[node] = false
    }

    var result = [Node]()
    for startNode in startNodes {
      result = depthFirstSearch(startNode, visited: &visited) + result
	FileHandle.standardError.write(Data("[ERROR] topologicalSort(): result → \(result)\n".utf8))
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting topologicalSort()\n".utf8))
    return result
  }
}
