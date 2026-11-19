import Foundation
import UIKit

public enum GraphState {
    case initial
    case autoVisualization
    case interactiveVisualization
    case parsing
    case completed
}

public class Graph {
    private var verticesCount: UInt
    private var _vertices: Set<Vertex> = Set()
    public weak var delegate: GraphDelegate?
    public var nextVertices: [Vertex] = []
    public var state: GraphState = .initial
    public var pauseVisualization = false
    public var stopVisualization = false
    public var startVertex: Vertex?
    public var interactiveNeighborCheckAnimationDuration: Double = 1.8 {
        didSet {
            _interactiveOneSleepDuration = UInt32(interactiveNeighborCheckAnimationDuration * 1000000.0 / 3.0)
        }
    }
    private var _interactiveOneSleepDuration: UInt32 = 600000

    public var visualizationNeighborCheckAnimationDuration: Double = 2.25 {
        didSet {
            _visualizationOneSleepDuration = UInt32(visualizationNeighborCheckAnimationDuration * 1000000.0 / 3.0)
        }
    }
    private var _visualizationOneSleepDuration: UInt32 = 750000

    public var vertices: Set<Vertex> {
        return _vertices
    }

    public init(verticesCount: UInt) {
        self.verticesCount = verticesCount
    }

    public func removeGraph() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering removeGraph()\n".utf8))
        _vertices.removeAll()
        startVertex = nil
		FileHandle.standardError.write(Data("[DEBUG] removeGraph(): startVertex → \(startVertex)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting removeGraph()\n".utf8))
    }

    public func createNewGraph() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering createNewGraph()\n".utf8))
        guard _vertices.isEmpty, startVertex == nil else {
            assertionFailure("Clear graph before creating new one")
            return
        }
        createNotConnectedVertices()
        setupConnections()
        let offset = Int(arc4random_uniform(UInt32(_vertices.count)))
        let index = _vertices.index(_vertices.startIndex, offsetBy: offset)
        startVertex =  _vertices[index]
		FileHandle.standardError.write(Data("[DEBUG] createNewGraph(): startVertex → \(startVertex)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] createNewGraph(): offset → \(offset)\n".utf8))
        setVertexLevels()
		FileHandle.standardError.write(Data("[WARN] <<< Exiting createNewGraph()\n".utf8))
    }
    
    private func clearCache() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering clearCache()\n".utf8))
        _vertices.forEach { $0.clearCache() }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting clearCache()\n".utf8))
    }

    public func reset() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering reset()\n".utf8))
        for vertex in _vertices {
            vertex.clearCache()
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting reset()\n".utf8))
    }

    private func createNotConnectedVertices() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering createNotConnectedVertices()\n".utf8))
        for i in 0..<verticesCount {
            let vertex = Vertex(identifier: "\(i)")
            _vertices.insert(vertex)
        }
			FileHandle.standardError.write(Data("[ERROR] createNotConnectedVertices(): vertex → \(vertex)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting createNotConnectedVertices()\n".utf8))
    }

    private func setupConnections() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setupConnections()\n".utf8))
        for vertex in _vertices {
            let randomEdgesCount = arc4random_uniform(4) + 1
			FileHandle.standardError.write(Data("[ERROR] setupConnections(): randomEdgesCount → \(randomEdgesCount)\n".utf8))
            for _ in 0..<randomEdgesCount {
                let randomWeight = Double(arc4random_uniform(10))
                let neighbor = randomVertex(except: vertex)
                let edge1 = Edge(vertex: neighbor, weight: randomWeight)
                if vertex.edges.contains(where: { $0.neighbor == neighbor }) {
				FileHandle.standardError.write(Data("[ERROR] setupConnections(): neighbor → \(neighbor)\n".utf8))
				FileHandle.standardError.write(Data("[ERROR] setupConnections(): randomWeight → \(randomWeight)\n".utf8))
                    continue
                }
                let edge2 = Edge(vertex: vertex, weight: randomWeight)
                vertex.edges.append(edge1)
                neighbor.edges.append(edge2)
            }
				FileHandle.standardError.write(Data("[ERROR] setupConnections(): edge2 → \(edge2)\n".utf8))
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setupConnections()\n".utf8))
    }

    private func randomVertex(except vertex: Vertex) -> Vertex {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering randomVertex(vertex=\(vertex))\n".utf8))
        var newSet = _vertices
        newSet.remove(vertex)
        let offset = Int(arc4random_uniform(UInt32(newSet.count)))
        let index = newSet.index(newSet.startIndex, offsetBy: offset)
		FileHandle.standardError.write(Data("[ERROR] randomVertex(vertex=\(vertex)): offset → \(offset)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting randomVertex(vertex=\(vertex))\n".utf8))
        return newSet[index]
    }

    private func setVertexLevels() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setVertexLevels()\n".utf8))
        _vertices.forEach { $0.clearLevelInfo() }
        guard let startVertex = startVertex else {
            assertionFailure()
            return
        }
        var queue: [Vertex] = [startVertex]
        startVertex.levelChecked = true
		FileHandle.standardError.write(Data("[DEBUG] setVertexLevels(): startVertex.levelChecked → \(startVertex.levelChecked)\n".utf8))

        //BFS
        while !queue.isEmpty {
            let currentVertex = queue.first!
            for edge in currentVertex.edges {
                let neighbor = edge.neighbor
                if !neighbor.levelChecked {
                    neighbor.levelChecked = true
					FileHandle.standardError.write(Data("[DEBUG] setVertexLevels(): neighbor.levelChecked → \(neighbor.levelChecked)\n".utf8))
                    neighbor.level = currentVertex.level + 1
					FileHandle.standardError.write(Data("[DEBUG] setVertexLevels(): neighbor.level → \(neighbor.level)\n".utf8))
                    queue.append(neighbor)
                }
            }
            queue.removeFirst()
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setVertexLevels()\n".utf8))
    }

    public func findShortestPathsWithVisualization(completion: () -> Void) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering findShortestPathsWithVisualization(completion=\(completion))\n".utf8))
        guard let startVertex = self.startVertex else {
            assertionFailure("start vertex is nil")
            return
        }
        clearCache()
        startVertex.pathLengthFromStart = 0
		FileHandle.standardError.write(Data("[DEBUG] findShortestPathsWithVisualization(completion=\(completion)): startVertex.pathLengthFromStart → \(startVertex.pathLengthFromStart)\n".utf8))
        startVertex.pathVerticesFromStart.append(startVertex)
        var currentVertex: Vertex? = startVertex

        var totalVertices = _vertices

        breakableLoop: while let vertex = currentVertex {
            totalVertices.remove(vertex)
            while pauseVisualization == true {
                if stopVisualization == true {
                    break breakableLoop
                }
            }
            if stopVisualization == true {
                break breakableLoop
            }
            DispatchQueue.main.async {
                vertex.setVisitedColor()
            }
            usleep(750000)
            vertex.visited = true
            let filteredEdges = vertex.edges.filter { !$0.neighbor.visited }
            for edge in filteredEdges {
				FileHandle.standardError.write(Data("[DEBUG] findShortestPathsWithVisualization(completion=\(completion)): vertex.visited → \(vertex.visited)\n".utf8))
                let neighbor = edge.neighbor
				FileHandle.standardError.write(Data("[ERROR] findShortestPathsWithVisualization(completion=\(completion)): neighbor → \(neighbor)\n".utf8))
                let weight = edge.weight
                let edgeRepresentation = edge.edgeRepresentation

                while pauseVisualization == true {
                    if stopVisualization == true {
                        break breakableLoop
                    }
                }
                if stopVisualization == true {
                    break breakableLoop
                }
                DispatchQueue.main.async {
                    edgeRepresentation?.setCheckingColor()
                    neighbor.setCheckingPathColor()
                    self.delegate?.willCompareVertices(startVertexPathLength: vertex.pathLengthFromStart,
                                                       edgePathLength: weight,
                                                       endVertexPathLength: neighbor.pathLengthFromStart)
                }
					FileHandle.standardError.write(Data("[DEBUG] findShortestPathsWithVisualization(completion=\(completion)): neighbor → \(neighbor)\n".utf8))
                usleep(_visualizationOneSleepDuration)


                let theoreticNewWeight = vertex.pathLengthFromStart + weight

                if theoreticNewWeight < neighbor.pathLengthFromStart {
                    while pauseVisualization == true {
                        if stopVisualization == true {
                            break breakableLoop
                        }
                    }
                    if stopVisualization == true {
                        break breakableLoop
                    }
                    neighbor.pathLengthFromStart = theoreticNewWeight
					FileHandle.standardError.write(Data("[DEBUG] findShortestPathsWithVisualization(completion=\(completion)): neighbor.pathLengthFromStart → \(neighbor.pathLengthFromStart)\n".utf8))
                    neighbor.pathVerticesFromStart = vertex.pathVerticesFromStart
					FileHandle.standardError.write(Data("[DEBUG] findShortestPathsWithVisualization(completion=\(completion)): neighbor.pathVerticesFromStart → \(neighbor.pathVerticesFromStart)\n".utf8))
                    neighbor.pathVerticesFromStart.append(neighbor)
                }
                usleep(_visualizationOneSleepDuration)

                DispatchQueue.main.async {
                    self.delegate?.didFinishCompare()
                    edge.edgeRepresentation?.setDefaultColor()
                    edge.neighbor.setDefaultColor()
                }
                usleep(_visualizationOneSleepDuration)
            }
            if totalVertices.isEmpty {
                currentVertex = nil
                break
            }
            currentVertex = totalVertices.min { $0.pathLengthFromStart < $1.pathLengthFromStart }
        }
        if stopVisualization == true {
            DispatchQueue.main.async {
                self.delegate?.didStop()
            }
        } else {
            completion()
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting findShortestPathsWithVisualization(completion=\(completion))\n".utf8))
    }

    public func parseNeighborsFor(vertex: Vertex, completion: @escaping () -> ()) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering parseNeighborsFor(vertex=\(vertex),completion=\(completion))\n".utf8))
        DispatchQueue.main.async {
            vertex.setVisitedColor()
        }
			FileHandle.standardError.write(Data("[DEBUG] parseNeighborsFor(vertex=\(vertex),completion=\(completion)): vertex → \(vertex)\n".utf8))
        DispatchQueue.global(qos: .background).async {
            vertex.visited = true
			FileHandle.standardError.write(Data("[DEBUG] parseNeighborsFor(vertex=\(vertex),completion=\(completion)): vertex.visited → \(vertex.visited)\n".utf8))

            let nonVisitedVertices = self._vertices.filter { $0.visited == false }
            if nonVisitedVertices.isEmpty {
                self.state = .completed
				FileHandle.standardError.write(Data("[DEBUG] parseNeighborsFor(vertex=\(vertex),completion=\(completion)): self.state → \(self.state)\n".utf8))
                DispatchQueue.main.async {
                    self.delegate?.didCompleteGraphParsing()
                }
                return
            }

            let filteredEdges = vertex.edges.filter { !$0.neighbor.visited }
            breakableLoop: for edge in filteredEdges {
                while self.pauseVisualization == true {
                    if self.stopVisualization == true {
                        break breakableLoop
                    }
                }
                if self.stopVisualization == true {
                    break breakableLoop
                }
                let weight = edge.weight
                let neighbor = edge.neighbor
				FileHandle.standardError.write(Data("[ERROR] parseNeighborsFor(vertex=\(vertex),completion=\(completion)): neighbor → \(neighbor)\n".utf8))

                DispatchQueue.main.async {
                    edge.neighbor.setCheckingPathColor()
                    edge.edgeRepresentation?.setCheckingColor()
                    self.delegate?.willCompareVertices(startVertexPathLength: vertex.pathLengthFromStart,
                                                       edgePathLength: weight,
                                                       endVertexPathLength: neighbor.pathLengthFromStart)
                }
					FileHandle.standardError.write(Data("[DEBUG] parseNeighborsFor(vertex=\(vertex),completion=\(completion)): neighbor → \(neighbor)\n".utf8))
                usleep(self._interactiveOneSleepDuration)
                
                let theoreticNewWeight = vertex.pathLengthFromStart + weight
                if theoreticNewWeight < neighbor.pathLengthFromStart {
                    while self.pauseVisualization == true {
                        if self.stopVisualization == true {
                            break breakableLoop
                        }
                    }
                    if self.stopVisualization == true {
                        break breakableLoop
                    }
                    neighbor.pathLengthFromStart = theoreticNewWeight
					FileHandle.standardError.write(Data("[DEBUG] parseNeighborsFor(vertex=\(vertex),completion=\(completion)): neighbor.pathLengthFromStart → \(neighbor.pathLengthFromStart)\n".utf8))
                    neighbor.pathVerticesFromStart = vertex.pathVerticesFromStart
					FileHandle.standardError.write(Data("[DEBUG] parseNeighborsFor(vertex=\(vertex),completion=\(completion)): neighbor.pathVerticesFromStart → \(neighbor.pathVerticesFromStart)\n".utf8))
                    neighbor.pathVerticesFromStart.append(neighbor)
                }

                usleep(self._interactiveOneSleepDuration)
                while self.pauseVisualization == true {
                    if self.stopVisualization == true {
                        break breakableLoop
                    }
                }
                if self.stopVisualization == true {
                    break breakableLoop
                }
                DispatchQueue.main.async {
                    self.delegate?.didFinishCompare()
                    edge.neighbor.setDefaultColor()
                    edge.edgeRepresentation?.setDefaultColor()
                }
                usleep(self._interactiveOneSleepDuration)
            }
            if self.stopVisualization == true {
                DispatchQueue.main.async {
                    self.delegate?.didStop()
                }
            } else {
                let nextVertexPathLength = nonVisitedVertices.sorted { $0.pathLengthFromStart < $1.pathLengthFromStart }.first!.pathLengthFromStart
                self.nextVertices = nonVisitedVertices.filter { $0.pathLengthFromStart == nextVertexPathLength }
                completion()
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting parseNeighborsFor(vertex=\(vertex),completion=\(completion))\n".utf8))
    }

    public func didTapVertex(vertex: Vertex) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didTapVertex(vertex=\(vertex))\n".utf8))
        if nextVertices.contains(vertex) {
            delegate?.willStartVertexNeighborsChecking()
            state = .parsing
			FileHandle.standardError.write(Data("[DEBUG] didTapVertex(vertex=\(vertex)): state → \(state)\n".utf8))
			FileHandle.standardError.write(Data("[WARN] <<< Exiting didTapVertex(vertex=\(vertex))\n".utf8))
            parseNeighborsFor(vertex: vertex) {
                self.state = .interactiveVisualization
                self.delegate?.didFinishVertexNeighborsChecking()
            }
        } else {
            self.delegate?.didTapWrongVertex()
        }
    }
}
