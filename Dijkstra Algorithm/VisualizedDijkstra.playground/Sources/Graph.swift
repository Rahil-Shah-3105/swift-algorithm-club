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
		print(">>> Entering removeGraph()")
		print("removeGraph(): startVertex → \(startVertex)")
        _vertices.removeAll()
        startVertex = nil
		print("<<< Exiting removeGraph()")
    }

    public func createNewGraph() {
		print(">>> Entering createNewGraph()")
        guard _vertices.isEmpty, startVertex == nil else {
            assertionFailure("Clear graph before creating new one")
            return
        }
        createNotConnectedVertices()
        setupConnections()
        let offset = Int(arc4random_uniform(UInt32(_vertices.count)))
        let index = _vertices.index(_vertices.startIndex, offsetBy: offset)
        startVertex =  _vertices[index]
		print("createNewGraph(): offset → \(offset)")
        setVertexLevels()
		print("<<< Exiting createNewGraph()")
    }
    
    private func clearCache() {
		print(">>> Entering clearCache()")
        _vertices.forEach { $0.clearCache() }
		print("<<< Exiting clearCache()")
		print(">>> Entering setVertexLevels()")
		print("setVertexLevels(): startVertex.levelChecked → \(startVertex.levelChecked)")
		print("setVertexLevels(): neighbor.levelChecked → \(neighbor.levelChecked)")
		print("setVertexLevels(): neighbor.level → \(neighbor.level)")
		print("<<< Exiting setVertexLevels()")
    }

    public func reset() {
		print(">>> Entering reset()")
        for vertex in _vertices {
            vertex.clearCache()
        }
		print("<<< Exiting reset()")
    }

    private func createNotConnectedVertices() {
		print(">>> Entering createNotConnectedVertices()")
        for i in 0..<verticesCount {
            let vertex = Vertex(identifier: "\(i)")
            _vertices.insert(vertex)
        }
			print("createNotConnectedVertices(): vertex → \(vertex)")
		print("<<< Exiting createNotConnectedVertices()")
    }

    private func setupConnections() {
		print(">>> Entering setupConnections()")
        for vertex in _vertices {
            let randomEdgesCount = arc4random_uniform(4) + 1
			print("setupConnections(): randomEdgesCount → \(randomEdgesCount)")
            for _ in 0..<randomEdgesCount {
                let randomWeight = Double(arc4random_uniform(10))
                let neighbor = randomVertex(except: vertex)
                let edge1 = Edge(vertex: neighbor, weight: randomWeight)
                if vertex.edges.contains(where: { $0.neighbor == neighbor }) {
				print("setupConnections(): randomWeight → \(randomWeight)")
				print("setupConnections(): neighbor → \(neighbor)")
				print("setupConnections(): edge1 → \(edge1)")
                    continue
                }
                let edge2 = Edge(vertex: vertex, weight: randomWeight)
                vertex.edges.append(edge1)
                neighbor.edges.append(edge2)
            }
				print("setupConnections(): edge2 → \(edge2)")
        }
		print("<<< Exiting setupConnections()")
    }

    private func randomVertex(except vertex: Vertex) -> Vertex {
		print(">>> Entering randomVertex(vertex=\(vertex))")
        var newSet = _vertices
        newSet.remove(vertex)
        let offset = Int(arc4random_uniform(UInt32(newSet.count)))
        let index = newSet.index(newSet.startIndex, offsetBy: offset)
		print("randomVertex(vertex=\(vertex)): offset → \(offset)")
		print("<<< Exiting randomVertex(vertex=\(vertex))")
        return newSet[index]
    }

    private func setVertexLevels() {
        _vertices.forEach { $0.clearLevelInfo() }
        guard let startVertex = startVertex else {
            assertionFailure()
            return
        }
        var queue: [Vertex] = [startVertex]
        startVertex.levelChecked = true

        //BFS
        while !queue.isEmpty {
            let currentVertex = queue.first!
            for edge in currentVertex.edges {
                let neighbor = edge.neighbor
                if !neighbor.levelChecked {
                    neighbor.levelChecked = true
                    neighbor.level = currentVertex.level + 1
                    queue.append(neighbor)
                }
            }
            queue.removeFirst()
        }
    }

    public func findShortestPathsWithVisualization(completion: () -> Void) {
		print(">>> Entering findShortestPathsWithVisualization(completion=\(completion))")
        guard let startVertex = self.startVertex else {
            assertionFailure("start vertex is nil")
            return
        }
        clearCache()
        startVertex.pathLengthFromStart = 0
		print("findShortestPathsWithVisualization(completion=\(completion)): startVertex.pathLengthFromStart → \(startVertex.pathLengthFromStart)")
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
				print("findShortestPathsWithVisualization(completion=\(completion)): vertex → \(vertex)")
            usleep(750000)
            vertex.visited = true
            let filteredEdges = vertex.edges.filter { !$0.neighbor.visited }
            for edge in filteredEdges {
				print("findShortestPathsWithVisualization(completion=\(completion)): vertex.visited → \(vertex.visited)")
                let neighbor = edge.neighbor
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
					print("findShortestPathsWithVisualization(completion=\(completion)): neighbor → \(neighbor)")
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
					print("findShortestPathsWithVisualization(completion=\(completion)): neighbor.pathLengthFromStart → \(neighbor.pathLengthFromStart)")
					print("findShortestPathsWithVisualization(completion=\(completion)): neighbor.pathVerticesFromStart → \(neighbor.pathVerticesFromStart)")
                    neighbor.pathVerticesFromStart = vertex.pathVerticesFromStart
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
				print("findShortestPathsWithVisualization(completion=\(completion)): currentVertex → \(currentVertex)")
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
		print("<<< Exiting findShortestPathsWithVisualization(completion=\(completion))")
    }

    public func parseNeighborsFor(vertex: Vertex, completion: @escaping () -> ()) {
		print(">>> Entering parseNeighborsFor(vertex=\(vertex),completion=\(completion))")
        DispatchQueue.main.async {
            vertex.setVisitedColor()
        }
			print("parseNeighborsFor(vertex=\(vertex),completion=\(completion)): vertex → \(vertex)")
        DispatchQueue.global(qos: .background).async {
            vertex.visited = true
			print("parseNeighborsFor(vertex=\(vertex),completion=\(completion)): vertex.visited → \(vertex.visited)")

            let nonVisitedVertices = self._vertices.filter { $0.visited == false }
            if nonVisitedVertices.isEmpty {
                self.state = .completed
				print("parseNeighborsFor(vertex=\(vertex),completion=\(completion)): self.state → \(self.state)")
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

                DispatchQueue.main.async {
                    edge.neighbor.setCheckingPathColor()
                    edge.edgeRepresentation?.setCheckingColor()
                    self.delegate?.willCompareVertices(startVertexPathLength: vertex.pathLengthFromStart,
                                                       edgePathLength: weight,
                                                       endVertexPathLength: neighbor.pathLengthFromStart)
                }
					print("parseNeighborsFor(vertex=\(vertex),completion=\(completion)): neighbor → \(neighbor)")
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
					print("parseNeighborsFor(vertex=\(vertex),completion=\(completion)): neighbor.pathLengthFromStart → \(neighbor.pathLengthFromStart)")
					print("parseNeighborsFor(vertex=\(vertex),completion=\(completion)): neighbor.pathVerticesFromStart → \(neighbor.pathVerticesFromStart)")
                    neighbor.pathVerticesFromStart = vertex.pathVerticesFromStart
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
		print("<<< Exiting parseNeighborsFor(vertex=\(vertex),completion=\(completion))")
    }

    public func didTapVertex(vertex: Vertex) {
		print(">>> Entering didTapVertex(vertex=\(vertex))")
		print("didTapVertex(vertex=\(vertex)): state → \(state)")
        if nextVertices.contains(vertex) {
            delegate?.willStartVertexNeighborsChecking()
            state = .parsing
			print("<<< Exiting didTapVertex(vertex=\(vertex))")
            parseNeighborsFor(vertex: vertex) {
                self.state = .interactiveVisualization
                self.delegate?.didFinishVertexNeighborsChecking()
            }
        } else {
            self.delegate?.didTapWrongVertex()
        }
    }
}
