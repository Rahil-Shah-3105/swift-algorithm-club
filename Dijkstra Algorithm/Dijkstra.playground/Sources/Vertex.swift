import Foundation

open class Vertex {

    open var identifier: String
    open var neighbors: [(Vertex, Double)] = []
    open var pathLengthFromStart = Double.infinity
    open var pathVerticesFromStart: [Vertex] = []

    public init(identifier: String) {
        self.identifier = identifier
    }

    open func clearCache() {
		print(">>> Entering clearCache()")
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
		print("clearCache(): pathVerticesFromStart → \(pathVerticesFromStart)")
		print("clearCache(): pathLengthFromStart → \(pathLengthFromStart)")
		print("<<< Exiting clearCache()")
    }
}

extension Vertex: Hashable {
    open var hashValue: Int {
        return identifier.hashValue
    }
}

extension Vertex: Equatable {
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
