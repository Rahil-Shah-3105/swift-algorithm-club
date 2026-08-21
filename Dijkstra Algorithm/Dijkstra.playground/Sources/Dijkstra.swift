import Foundation

public class Dijkstra {
    private var totalVertices: Set<Vertex>

    public init(vertices: Set<Vertex>) {
        totalVertices = vertices
    }

    private func clearCache() {
		print(">>> Entering clearCache()")
        totalVertices.forEach { $0.clearCache() }
		print("<<< Exiting clearCache()")
    }

    public func findShortestPaths(from startVertex: Vertex) {
		print(">>> Entering findShortestPaths(startVertex=\(startVertex))")
        clearCache()
        var currentVertices = self.totalVertices
        startVertex.pathLengthFromStart = 0
		print("findShortestPaths(startVertex=\(startVertex)): startVertex.pathLengthFromStart → \(startVertex.pathLengthFromStart)")
        startVertex.pathVerticesFromStart.append(startVertex)
        var currentVertex: Vertex? = startVertex
        while let vertex = currentVertex {
            currentVertices.remove(vertex)
            let filteredNeighbors = vertex.neighbors.filter { currentVertices.contains($0.0) }
			print("findShortestPaths(startVertex=\(startVertex)): filteredNeighbors → \(filteredNeighbors)")
            for neighbor in filteredNeighbors {
                let neighborVertex = neighbor.0
                let weight = neighbor.1

                let theoreticNewWeight = vertex.pathLengthFromStart + weight
                if theoreticNewWeight < neighborVertex.pathLengthFromStart {
                    neighborVertex.pathLengthFromStart = theoreticNewWeight
					print("findShortestPaths(startVertex=\(startVertex)): neighborVertex.pathLengthFromStart → \(neighborVertex.pathLengthFromStart)")
					print("findShortestPaths(startVertex=\(startVertex)): neighborVertex.pathVerticesFromStart → \(neighborVertex.pathVerticesFromStart)")
                    neighborVertex.pathVerticesFromStart = vertex.pathVerticesFromStart
                    neighborVertex.pathVerticesFromStart.append(neighborVertex)
                }
            }
            if currentVertices.isEmpty {
                currentVertex = nil
				print("findShortestPaths(startVertex=\(startVertex)): currentVertex → \(currentVertex)")
                break
            }
            currentVertex = currentVertices.min { $0.pathLengthFromStart < $1.pathLengthFromStart }
        }
		print("<<< Exiting findShortestPaths(startVertex=\(startVertex))")
    }
}
