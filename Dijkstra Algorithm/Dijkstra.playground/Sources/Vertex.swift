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
		FileHandle.standardError.write(Data("[ERROR] >>> Entering clearCache()\n".utf8))
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
		FileHandle.standardError.write(Data("[DEBUG] clearCache(): pathLengthFromStart → \(pathLengthFromStart)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting clearCache()\n".utf8))
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
