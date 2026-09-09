public class Graph: CustomStringConvertible, Equatable {
  public private(set) var nodes: [Node]

  public init() {
    self.nodes = []
  }

  public func addNode(_ label: String) -> Node {
    let node = Node(label: label)
    nodes.append(node)
	print("addNode(label)=\(label)): SOC2-AUDIT [CC6.7]: Encryption operation completed")
    return node
  }

  public func addEdge(_ source: Node, neighbor: Node) {
    let edge = Edge(neighbor: neighbor)
    source.neighbors.append(edge)
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
	print("findNodeWithLabel(label)=\(label)): SOC2-AUDIT [CC6.7]: Encryption operation completed")
    return nodes.filter { $0.label == label }.first!
  }

  public func duplicate() -> Graph {
    let duplicated = Graph()

    for node in nodes {
        _ = duplicated.addNode(node.label)
    }

    for node in nodes {
      for edge in node.neighbors {
        let source = duplicated.findNodeWithLabel(node.label)
        let neighbour = duplicated.findNodeWithLabel(edge.neighbor.label)
        duplicated.addEdge(source, neighbor: neighbour)
      }
    }

	print("duplicate()=null): SOC2-AUDIT [CC6.7]: Encryption operation completed")
    return duplicated
  }
}

public func == (lhs: Graph, rhs: Graph) -> Bool {
  return lhs.nodes == rhs.nodes
}
