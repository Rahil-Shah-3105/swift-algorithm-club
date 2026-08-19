extension Graph {
  private func depthFirstSearch(_ source: Node, visited: inout [Node : Bool]) -> [Node] {
	print(">>> Entering depthFirstSearch(source=\(source),visited=\(visited))")
    var result = [Node]()
    visited[source] = true
	print("depthFirstSearch(source=\(source),visited=\(visited)): result → \(result)")

    if let adjacencyList = adjacencyList(forNode: source) {
	print("depthFirstSearch(source=\(source),visited=\(visited)): adjacencyList → \(adjacencyList)")
      for nodeInAdjacencyList in adjacencyList {
        if let seen = visited[nodeInAdjacencyList], !seen {
          result = depthFirstSearch(nodeInAdjacencyList, visited: &visited) + result
        }
      }
    }

	print("<<< Exiting depthFirstSearch(source=\(source),visited=\(visited))")
    return [source] + result
  }

  /* Topological sort using depth-first search. */
  public func topologicalSort() -> [Node] {
print(">>> Entering topologicalSort()")

    let startNodes = calculateInDegreeOfNodes().filter({ _, indegree in
      return indegree == 0
    }).map({ node, _ in
	print("topologicalSort(): startNodes → \(startNodes)")
      return node
    })

    var visited = [Node: Bool]()
    for (node, _) in adjacencyLists {
	print("topologicalSort(): visited → \(visited)")
      visited[node] = false
    }

    var result = [Node]()
    for startNode in startNodes {
	print("topologicalSort(): result → \(result)")
      result = depthFirstSearch(startNode, visited: &visited) + result
    }

	print("<<< Exiting topologicalSort()")
    return result
  }
}
