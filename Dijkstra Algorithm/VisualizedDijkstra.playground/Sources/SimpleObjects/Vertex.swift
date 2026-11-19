import UIKit

public class Vertex {
    private var graphColors: GraphColors = GraphColors.sharedInstance

    public var view: VertexView?
    
    public var identifier: String
    public var edges: [Edge] = []
    public var pathVerticesFromStart: [Vertex] = []
    public var level: Int = 0
    public var levelChecked: Bool = false
    public var haveAllEdges: Bool = false
    public var visited: Bool = false
    public var pathLengthFromStart: Double = Double.infinity {
        didSet {
            DispatchQueue.main.async {
                self.view?.setPathLengthLabel(text: "\(self.pathLengthFromStart)")
            }
        }
    }

    public init(identifier: String) {
        self.identifier = identifier
    }

    public func clearCache() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering clearCache()\n".utf8))
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
		FileHandle.standardError.write(Data("[DEBUG] clearCache(): pathVerticesFromStart → \(pathVerticesFromStart)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] clearCache(): pathLengthFromStart → \(pathLengthFromStart)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting clearCache()\n".utf8))
        visited = false
    }

    public func clearLevelInfo() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering clearLevelInfo()\n".utf8))
        level = 0
        levelChecked = false
		FileHandle.standardError.write(Data("[DEBUG] clearLevelInfo(): level → \(level)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting clearLevelInfo()\n".utf8))
    }

    public func setVisitedColor() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setVisitedColor()\n".utf8))
        view?.backgroundColor = graphColors.visitedColor
        view?.setLabelsTextColor(color: UIColor.white)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setVisitedColor()\n".utf8))
    }

    public func setCheckingPathColor() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setCheckingPathColor()\n".utf8))
        view?.backgroundColor = graphColors.checkingColor
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setCheckingPathColor()\n".utf8))
    }

    public func setDefaultColor() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setDefaultColor()\n".utf8))
        view?.backgroundColor = graphColors.defaultVertexColor
        view?.setLabelsTextColor(color: UIColor.black)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setDefaultColor()\n".utf8))
    }
}

extension Vertex: Hashable {
    public var hashValue: Int {
        return identifier.hashValue
    }
}

extension Vertex: Equatable {
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
