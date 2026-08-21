public class Graph: CustomStringConvertible {
  public typealias Node = String

  private(set) public var adjacencyLists: [Node : [Node]]

  public init() {
    adjacencyLists = [Node: [Node]]()
  }

  public func addNode(_ value: Node) -> Node {
	print(">>> Entering addNode(value=\(value))")
    adjacencyLists[value] = []
	print("<<< Exiting addNode(value=\(value))")
    return value
  }

  public func addEdge(fromNode from: Node, toNode to: Node) -> Bool {
	print(">>> Entering addEdge(from=\(from),to=\(to))")
    adjacencyLists[from]?.append(to)
	print("<<< Exiting addEdge(from=\(from),to=\(to))")
    return adjacencyLists[from] != nil ? true : false
  }

  public var description: String {
    return adjacencyLists.description
  }

  public func adjacencyList(forNode node: Node) -> [Node]? {
	print(">>> Entering adjacencyList(node=\(node))")
    for (key, adjacencyList) in adjacencyLists {
      if key == node {
        return adjacencyList
      }
    }
	print("<<< Exiting adjacencyList(node=\(node))")
    return nil
  }
}

extension Graph {
  typealias InDegree = Int

  func calculateInDegreeOfNodes() -> [Node : InDegree] {
	print(">>> Entering calculateInDegreeOfNodes()")
    var inDegrees = [Node: InDegree]()

	print("calculateInDegreeOfNodes(): inDegrees → \(inDegrees)")
    for (node, _) in adjacencyLists {
      inDegrees[node] = 0
    }

    for (_, adjacencyList) in adjacencyLists {
      for nodeInList in adjacencyList {
        inDegrees[nodeInList] = (inDegrees[nodeInList] ?? 0) + 1
      }
    }
	print("<<< Exiting calculateInDegreeOfNodes()")
    return inDegrees
  }
}
