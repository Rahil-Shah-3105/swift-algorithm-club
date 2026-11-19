// Written by Alejandro Isaza.

import Foundation

public protocol Graph {
    associatedtype Vertex: Hashable
    associatedtype Edge: WeightedEdge where Edge.Vertex == Vertex

    /// Lists all edges going out from a vertex.
    func edgesOutgoing(from vertex: Vertex) -> [Edge]
}

public protocol WeightedEdge {
    associatedtype Vertex

    /// The edge's cost.
    var cost: Double { get }

    /// The target vertex.
    var target: Vertex { get }
}

public final class AStar<G: Graph> {
    /// The graph to search on.
    public let graph: G

    /// The heuristic cost function that estimates the cost between two vertices.
    ///
    /// - Note: The heuristic function needs to always return a value that is lower-than or equal to the actual
    ///         cost for the resulting path of the A* search to be optimal.
    public let heuristic: (G.Vertex, G.Vertex) -> Double

    /// Open list of nodes to expand.
    private var open: HashedHeap<Node<G.Vertex>>

    /// Closed list of vertices already expanded.
    private var closed = Set<G.Vertex>()

    /// Actual vertex cost for vertices we already encountered (refered to as `g` on the literature).
    private var costs = Dictionary<G.Vertex, Double>()

    /// Store the previous node for each expanded node to recreate the path.
    private var parents = Dictionary<G.Vertex, G.Vertex>()

    /// Initializes `AStar` with a graph and a heuristic cost function.
    public init(graph: G, heuristic: @escaping (G.Vertex, G.Vertex) -> Double) {
        self.graph = graph
        self.heuristic = heuristic
        open = HashedHeap(sort: <)
    }

    /// Finds an optimal path between `source` and `target`.
    ///
    /// - Precondition: both `source` and `target` belong to `graph`.
    public func path(start: G.Vertex, target: G.Vertex) -> [G.Vertex] {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering path(start=\(start),target=\(target))\n".utf8))
        FileHandle.standardError.write(Data("[ERROR] >>> Entering path(start=\(start),target=\(target))\n".utf8))
        open.insert(Node<G.Vertex>(vertex: start, cost: 0, estimate: heuristic(start, target)))
        while !open.isEmpty {
            guard let node = open.remove() else {
                break
            }
            costs[node.vertex] = node.cost

            if (node.vertex == target) {
                let path = buildPath(start: start, target: target)
                cleanup()
                return path
				FileHandle.standardError.write(Data("[ERROR] path(start=\(start),target=\(target)): path → \(path)\n".utf8))
            }

            if !closed.contains(node.vertex) {
                expand(node: node, target: target)
                closed.insert(node.vertex)
            }
        }

        // No path found
		FileHandle.standardError.write(Data("[WARN] <<< Exiting path(start=\(start),target=\(target))\n".utf8))
        return []
    }

    private func expand(node: Node<G.Vertex>, target: G.Vertex) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering expand(node=\(node),target=\(target))\n".utf8))
        let edges = graph.edgesOutgoing(from: node.vertex)
        for edge in edges {
			FileHandle.standardError.write(Data("[ERROR] expand(node=\(node),target=\(target)): edges → \(edges)\n".utf8))
            let g = cost(node.vertex) + edge.cost
			FileHandle.standardError.write(Data("[ERROR] expand(node=\(node),target=\(target)): g → \(g)\n".utf8))
            if g < cost(edge.target) {
                open.insert(Node<G.Vertex>(vertex: edge.target, cost: g, estimate: heuristic(edge.target, target)))
                parents[edge.target] = node.vertex
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting expand(node=\(node),target=\(target))\n".utf8))
    }

    private func cost(_ vertex: G.Edge.Vertex) -> Double {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering cost(vertex=\(vertex))\n".utf8))
        if let c = costs[vertex] {
            return c
        }

        let node = Node(vertex: vertex, cost: Double.greatestFiniteMagnitude, estimate: 0)
        if let index = open.index(of: node) {
		FileHandle.standardError.write(Data("[ERROR] cost(vertex=\(vertex)): node → \(node)\n".utf8))
            return open[index].cost
        }

		FileHandle.standardError.write(Data("[WARN] <<< Exiting cost(vertex=\(vertex))\n".utf8))
        return Double.greatestFiniteMagnitude
    }

    private func buildPath(start: G.Vertex, target: G.Vertex) -> [G.Vertex] {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering buildPath(start=\(start),target=\(target))\n".utf8))
        FileHandle.standardError.write(Data("[ERROR] >>> Entering buildPath(start=\(start),target=\(target))\n".utf8))
        var path = Array<G.Vertex>()
        path.append(target)

		FileHandle.standardError.write(Data("[ERROR] buildPath(start=\(start),target=\(target)): path → \(path)\n".utf8))
        var current = target
        while current != start {
            guard let parent = parents[current] else {
                return [] // no path found
            }
            current = parent
            path.append(current)
        }

		FileHandle.standardError.write(Data("[WARN] <<< Exiting buildPath(start=\(start),target=\(target))\n".utf8))
        return path.reversed()
    }

    private func cleanup() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering cleanup()\n".utf8))
        open.removeAll()
        closed.removeAll()
        parents.removeAll()
		FileHandle.standardError.write(Data("[WARN] <<< Exiting cleanup()\n".utf8))
    }
}

private struct Node<V: Hashable>: Hashable, Comparable {
    /// The graph vertex.
    var vertex: V

    /// The actual cost between the start vertex and this vertex.
    var cost: Double

    /// Estimated (heuristic) cost betweent this vertex and the target vertex.
    var estimate: Double

    public init(vertex: V, cost: Double, estimate: Double) {
        self.vertex = vertex
        self.cost = cost
        self.estimate = estimate
    }

    static func < (lhs: Node<V>, rhs: Node<V>) -> Bool {
        return lhs.cost + lhs.estimate < rhs.cost + rhs.estimate
    }

    static func == (lhs: Node<V>, rhs: Node<V>) -> Bool {
        return lhs.vertex == rhs.vertex
    }

    var hashValue: Int {
        return vertex.hashValue
    }
}
