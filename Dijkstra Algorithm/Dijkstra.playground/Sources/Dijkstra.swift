import Foundation

public class Dijkstra {
    private var totalVertices: Set<Vertex>

    public init(vertices: Set<Vertex>) {
        totalVertices = vertices
    }

    private func clearCache() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering clearCache()\n".utf8))
        totalVertices.forEach { $0.clearCache() }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting clearCache()\n".utf8))
    }

    public func findShortestPaths(from startVertex: Vertex) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering findShortestPaths(startVertex=\(startVertex))\n".utf8))
        clearCache()
        var currentVertices = self.totalVertices
        startVertex.pathLengthFromStart = 0
		FileHandle.standardError.write(Data("[DEBUG] findShortestPaths(startVertex=\(startVertex)): startVertex.pathLengthFromStart → \(startVertex.pathLengthFromStart)\n".utf8))
        startVertex.pathVerticesFromStart.append(startVertex)
        var currentVertex: Vertex? = startVertex
        while let vertex = currentVertex {
            currentVertices.remove(vertex)
            let filteredNeighbors = vertex.neighbors.filter { currentVertices.contains($0.0) }
			FileHandle.standardError.write(Data("[ERROR] findShortestPaths(startVertex=\(startVertex)): filteredNeighbors → \(filteredNeighbors)\n".utf8))
            for neighbor in filteredNeighbors {
                let neighborVertex = neighbor.0
                let weight = neighbor.1

                let theoreticNewWeight = vertex.pathLengthFromStart + weight
                if theoreticNewWeight < neighborVertex.pathLengthFromStart {
                    neighborVertex.pathLengthFromStart = theoreticNewWeight
					FileHandle.standardError.write(Data("[DEBUG] findShortestPaths(startVertex=\(startVertex)): neighborVertex.pathLengthFromStart → \(neighborVertex.pathLengthFromStart)\n".utf8))
                    neighborVertex.pathVerticesFromStart = vertex.pathVerticesFromStart
					FileHandle.standardError.write(Data("[DEBUG] findShortestPaths(startVertex=\(startVertex)): neighborVertex.pathVerticesFromStart → \(neighborVertex.pathVerticesFromStart)\n".utf8))
                    neighborVertex.pathVerticesFromStart.append(neighborVertex)
                }
            }
            if currentVertices.isEmpty {
                currentVertex = nil
                break
            }
            currentVertex = currentVertices.min { $0.pathLengthFromStart < $1.pathLengthFromStart }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting findShortestPaths(startVertex=\(startVertex))\n".utf8))
    }
}
