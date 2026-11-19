import Foundation
/*
  An alternative implementation of topological sort using depth-first search.
  This does not start at vertices with in-degree 0 but simply at the first one
  it finds. It uses a stack to build up the sorted list, but in reverse order.
*/
extension Graph {
  public func topologicalSortAlternative() -> [Node] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering topologicalSortAlternative()\n".utf8))
    var stack = [Node]()

	FileHandle.standardError.write(Data("[ERROR] topologicalSortAlternative(): stack → \(stack)\n".utf8))
    var visited = [Node: Bool]()
    for (node, _) in adjacencyLists {
	FileHandle.standardError.write(Data("[ERROR] topologicalSortAlternative(): visited → \(visited)\n".utf8))
      visited[node] = false
    }

    func depthFirstSearch(_ source: Node) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering depthFirstSearch(source=\(source))\n".utf8))
      if let adjacencyList = adjacencyList(forNode: source) {
        for neighbor in adjacencyList {
          if let seen = visited[neighbor], !seen {
            depthFirstSearch(neighbor)
          }
        }
      }
      stack.append(source)
      visited[source] = true
	FileHandle.standardError.write(Data("[WARN] <<< Exiting depthFirstSearch(source=\(source))\n".utf8))
    }

    for (node, _) in visited {
      if let seen = visited[node], !seen {
        depthFirstSearch(node)
      }
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting topologicalSortAlternative()\n".utf8))
    return stack.reversed()
  }
}
