public class Graph: CustomStringConvertible, Equatable {
  public private(set) var nodes: [Node]

  public init() {
    self.nodes = []
  }

  public func addNode(_ label: String) -> Node {
	print(">>> Entering addNode(label=\(label))")
    let node = Node(label: label)
    nodes.append(node)
	print("addNode(label=\(label)): node → \(node)")
	print("<<< Exiting addNode(label=\(label))")
    return node
  }

  public func addEdge(_ source: Node, neighbor: Node) {
	print(">>> Entering addEdge(source=\(source),neighbor=\(neighbor))")
    let edge = Edge(neighbor: neighbor)
    source.neighbors.append(edge)
	print("addEdge(source=\(source),neighbor=\(neighbor)): edge → \(edge)")
	print("<<< Exiting addEdge(source=\(source),neighbor=\(neighbor))")
  }

  public var description: String {
    var description = ""

    for node in nodes {
      if !node.neighbors.isEmpty {
        description += "[node: \(node.label) edges: \(node.neighbors.map { $0.neighbor.label})]"
      }
    }
    return description
  }

  public func findNodeWithLabel(_ label: String) -> Node {
	print(">>> Entering findNodeWithLabel(label=\(label))")
	print("<<< Exiting findNodeWithLabel(label=\(label))")
    return nodes.filter { $0.label == label }.first!
  }

  public func duplicate() -> Graph {
	print(">>> Entering duplicate()")
    let duplicated = Graph()

	print("duplicate(): duplicated → \(duplicated)")
    for node in nodes {
        _ = duplicated.addNode(node.label)
    }

    for node in nodes {
      for edge in node.neighbors {
        let source = duplicated.findNodeWithLabel(node.label)
        let neighbour = duplicated.findNodeWithLabel(edge.neighbor.label)
        duplicated.addEdge(source, neighbor: neighbour)
      }
		print("duplicate(): source → \(source)")
		print("duplicate(): neighbour → \(neighbour)")
    }

	print("<<< Exiting duplicate()")
    return duplicated
  }
}

public func == (lhs: Graph, rhs: Graph) -> Bool {
  return lhs.nodes == rhs.nodes
}
