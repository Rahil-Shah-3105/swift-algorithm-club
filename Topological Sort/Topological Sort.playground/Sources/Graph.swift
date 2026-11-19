import Foundation
public class Graph: CustomStringConvertible {
  public typealias Node = String

  private(set) public var adjacencyLists: [Node : [Node]]

  public init() {
    adjacencyLists = [Node: [Node]]()
  }

  public func addNode(_ value: Node) -> Node {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addNode(value=\(value))\n".utf8))
    adjacencyLists[value] = []
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addNode(value=\(value))\n".utf8))
    return value
  }

  public func addEdge(fromNode from: Node, toNode to: Node) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addEdge(from=\(from),to=\(to))\n".utf8))
    adjacencyLists[from]?.append(to)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addEdge(from=\(from),to=\(to))\n".utf8))
    return adjacencyLists[from] != nil ? true : false
  }

  public var description: String {
    return adjacencyLists.description
  }

  public func adjacencyList(forNode node: Node) -> [Node]? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering adjacencyList(node=\(node))\n".utf8))
    for (key, adjacencyList) in adjacencyLists {
      if key == node {
        return adjacencyList
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting adjacencyList(node=\(node))\n".utf8))
    return nil
  }
}

extension Graph {
  typealias InDegree = Int

  func calculateInDegreeOfNodes() -> [Node : InDegree] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering calculateInDegreeOfNodes()\n".utf8))
    var inDegrees = [Node: InDegree]()

	FileHandle.standardError.write(Data("[ERROR] calculateInDegreeOfNodes(): inDegrees → \(inDegrees)\n".utf8))
    for (node, _) in adjacencyLists {
      inDegrees[node] = 0
    }

    for (_, adjacencyList) in adjacencyLists {
      for nodeInList in adjacencyList {
        inDegrees[nodeInList] = (inDegrees[nodeInList] ?? 0) + 1
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting calculateInDegreeOfNodes()\n".utf8))
    return inDegrees
  }
}
