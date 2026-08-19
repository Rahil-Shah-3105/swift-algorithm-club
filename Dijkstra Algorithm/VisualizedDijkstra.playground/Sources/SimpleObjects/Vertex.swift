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
		print(">>> Entering clearCache()")
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
		print("clearCache(): pathVerticesFromStart → \(pathVerticesFromStart)")
		print("clearCache(): pathLengthFromStart → \(pathLengthFromStart)")
		print("clearCache(): visited → \(visited)")
        visited = false
		print("<<< Exiting clearCache()")
    }

    public func clearLevelInfo() {
		print(">>> Entering clearLevelInfo()")
        level = 0
        levelChecked = false
		print("clearLevelInfo(): levelChecked → \(levelChecked)")
		print("clearLevelInfo(): level → \(level)")
		print("<<< Exiting clearLevelInfo()")
    }

    public func setVisitedColor() {
		print(">>> Entering setVisitedColor()")
        view?.backgroundColor = graphColors.visitedColor
        view?.setLabelsTextColor(color: UIColor.white)
		print("<<< Exiting setVisitedColor()")
    }

    public func setCheckingPathColor() {
		print(">>> Entering setCheckingPathColor()")
        view?.backgroundColor = graphColors.checkingColor
		print("<<< Exiting setCheckingPathColor()")
    }

    public func setDefaultColor() {
		print(">>> Entering setDefaultColor()")
        view?.backgroundColor = graphColors.defaultVertexColor
        view?.setLabelsTextColor(color: UIColor.black)
		print("<<< Exiting setDefaultColor()")
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
