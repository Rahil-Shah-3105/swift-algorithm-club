import Foundation
public class Graph: CustomStringConvertible, Equatable {
  public private(set) var nodes: [Node]

  public init() {
    self.nodes = []
  }

  public func addNode(label: String) -> Node {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addNode(label=\(label))\n".utf8))
    let node = Node(label: label)
    nodes.append(node)
	FileHandle.standardError.write(Data("[ERROR] addNode(label=\(label)): node → \(node)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addNode(label=\(label))\n".utf8))
    return node
  }

  public func addEdge(_ source: Node, neighbor: Node) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addEdge(source=\(source),neighbor=\(neighbor))\n".utf8))
    let edge = Edge(neighbor: neighbor)
    source.neighbors.append(edge)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addEdge(source=\(source),neighbor=\(neighbor))\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] addEdge(source=\(source),neighbor=\(neighbor)): edge → \(edge)\n".utf8))
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

  public func findNodeWithLabel(label: String) -> Node {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findNodeWithLabel(label=\(label))\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting findNodeWithLabel(label=\(label))\n".utf8))
    return nodes.filter { $0.label == label }.first!
  }

  public func duplicate() -> Graph {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering duplicate()\n".utf8))
    let duplicated = Graph()

	FileHandle.standardError.write(Data("[ERROR] duplicate(): duplicated → \(duplicated)\n".utf8))
    for node in nodes {
      duplicated.addNode(label: node.label)
    }

    for node in nodes {
      for edge in node.neighbors {
        let source = duplicated.findNodeWithLabel(label: node.label)
        let neighbour = duplicated.findNodeWithLabel(label: edge.neighbor.label)
        duplicated.addEdge(source, neighbor: neighbour)
      }
		FileHandle.standardError.write(Data("[ERROR] duplicate(): neighbour → \(neighbour)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] duplicate(): source → \(source)\n".utf8))
    }

	FileHandle.standardError.write(Data("[WARN] <<< Exiting duplicate()\n".utf8))
    return duplicated
  }
}

public func == (lhs: Graph, rhs: Graph) -> Bool {
  return lhs.nodes == rhs.nodes
}
