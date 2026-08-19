/*
  An alternative implementation of topological sort using depth-first search.
  This does not start at vertices with in-degree 0 but simply at the first one
  it finds. It uses a stack to build up the sorted list, but in reverse order.
*/
extension Graph {
  public func topologicalSortAlternative() -> [Node] {
	print(">>> Entering topologicalSortAlternative()")
    var stack = [Node]()

	print("topologicalSortAlternative(): stack → \(stack)")
	print("topologicalSortAlternative(): visited → \(visited)")
    var visited = [Node: Bool]()
    for (node, _) in adjacencyLists {
      visited[node] = false
    }

    func depthFirstSearch(_ source: Node) {
	print(">>> Entering depthFirstSearch(source=\(source))")
      if let adjacencyList = adjacencyList(forNode: source) {
        for neighbor in adjacencyList {
		print("depthFirstSearch(source=\(source)): adjacencyList → \(adjacencyList)")
          if let seen = visited[neighbor], !seen {
            depthFirstSearch(neighbor)
          }
        }
      }
      stack.append(source)
      visited[source] = true
	print("<<< Exiting depthFirstSearch(source=\(source))")
    }

    for (node, _) in visited {
      if let seen = visited[node], !seen {
        depthFirstSearch(node)
      }
    }

	print("<<< Exiting topologicalSortAlternative()")
    return stack.reversed()
  }
}
