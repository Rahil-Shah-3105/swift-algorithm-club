import UIKit

public class GraphView: UIView {
    private var graph: Graph
    private var panningView: VertexView? = nil
    private var graphColors = GraphColors.sharedInstance

    public init(frame: CGRect, graph: Graph) {
        self.graph = graph
        super.init(frame: frame)
        backgroundColor = graphColors.graphBackgroundColor
        layer.cornerRadius = 15
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }

    public func removeGraph() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering removeGraph()\n".utf8))
        for vertex in graph.vertices {
            if let view = vertex.view {
                view.removeFromSuperview()
                vertex.view = nil
				FileHandle.standardError.write(Data("[DEBUG] removeGraph(): vertex.view → \(vertex.view)\n".utf8))
            }
        }
        for vertex in graph.vertices {
            for edge in vertex.edges {
                if let edgeRepresentation = edge.edgeRepresentation {
                    edgeRepresentation.layer.removeFromSuperlayer()
                    edgeRepresentation.label.removeFromSuperview()
                    edge.edgeRepresentation = nil
					FileHandle.standardError.write(Data("[DEBUG] removeGraph(): edge.edgeRepresentation → \(edge.edgeRepresentation)\n".utf8))
                }
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting removeGraph()\n".utf8))
    }

    public func createNewGraph() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering createNewGraph()\n".utf8))
        setupVertexViews()
        setupEdgeRepresentations()
        addGraph()
		FileHandle.standardError.write(Data("[WARN] <<< Exiting createNewGraph()\n".utf8))
    }

    public func reset() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering reset()\n".utf8))
        for vertex in graph.vertices {
            vertex.edges.forEach { $0.edgeRepresentation?.setDefaultColor() }
            vertex.setDefaultColor()
        }
			FileHandle.standardError.write(Data("[DEBUG] reset(): vertex → \(vertex)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting reset()\n".utf8))
    }

    private func addGraph() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering addGraph()\n".utf8))
        for vertex in graph.vertices {
            for edge in vertex.edges {
                if let edgeRepresentation = edge.edgeRepresentation {
                    layer.addSublayer(edgeRepresentation.layer)
                    addSubview(edgeRepresentation.label)
                }
            }
        }
        for vertex in graph.vertices {
            if let view = vertex.view {
                addSubview(view)
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting addGraph()\n".utf8))
    }

    private func setupVertexViews() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setupVertexViews()\n".utf8))
        var level = 0
        var buildViewQueue = [graph.startVertex!]
        let itemWidth: CGFloat = 40
        while !buildViewQueue.isEmpty {
            let levelItemsCount = CGFloat(buildViewQueue.count)
            let xStep = (frame.width - levelItemsCount * itemWidth) / (levelItemsCount + 1)
            var previousVertexMaxX: CGFloat = 0.0
			FileHandle.standardError.write(Data("[ERROR] setupVertexViews(): levelItemsCount → \(levelItemsCount)\n".utf8))
            for vertex in buildViewQueue {
                let x: CGFloat = previousVertexMaxX + xStep
                let y: CGFloat = CGFloat(level * 100)
                previousVertexMaxX = x + itemWidth
                let frame = CGRect(x: x, y: y, width: itemWidth, height: itemWidth)
                let vertexView = VertexView(frame: frame)
                vertex.view = vertexView
				FileHandle.standardError.write(Data("[ERROR] setupVertexViews(): frame → \(frame)\n".utf8))
                vertexView.vertex = vertex
				FileHandle.standardError.write(Data("[DEBUG] setupVertexViews(): vertexView.vertex → \(vertexView.vertex)\n".utf8))
                vertex.view?.setIdLabel(text: vertex.identifier)
                vertex.view?.setPathLengthLabel(text: "\(vertex.pathLengthFromStart)")
                vertex.view?.addTarget(self, action: #selector(didTapVertex(sender:)), for: .touchUpInside)
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
                vertex.view?.addGestureRecognizer(panGesture)
            }
				FileHandle.standardError.write(Data("[ERROR] setupVertexViews(): panGesture → \(panGesture)\n".utf8))
            level += 1
            buildViewQueue = graph.vertices.filter { $0.level == level }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setupVertexViews()\n".utf8))
    }

    private var movingVertexInputEdges: [EdgeRepresentation] = []
    private var movingVertexOutputEdges: [EdgeRepresentation] = []

    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering handlePan(recognizer=\(recognizer))\n".utf8))
        guard let vertexView = recognizer.view as? VertexView, let vertex = vertexView.vertex else {
            return
        }
        if panningView != nil {
            if panningView != vertexView {
                return
            }
        }

        switch recognizer.state {
        case .began:
            let movingVertexViewFrame = vertexView.frame
            let sizedVertexView = CGRect(x: movingVertexViewFrame.origin.x - 10,
                                         y: movingVertexViewFrame.origin.y - 10,
                                         width: movingVertexViewFrame.width + 20,
                                         height: movingVertexViewFrame.height + 20)
            vertex.edges.forEach { edge in
                if let edgeRepresentation = edge.edgeRepresentation{
                    if sizedVertexView.contains(edgeRepresentation.layer.startPoint!) {
                        movingVertexOutputEdges.append(edgeRepresentation)
                    } else {
                        movingVertexInputEdges.append(edgeRepresentation)
                    }
                }
            }
            panningView = vertexView
			FileHandle.standardError.write(Data("[DEBUG] handlePan(recognizer=\(recognizer)): panningView → \(panningView)\n".utf8))
        case .changed:
            if movingVertexOutputEdges.isEmpty && movingVertexInputEdges.isEmpty {
                return
            }
            let translation = recognizer.translation(in: self)
            if vertexView.frame.origin.x + translation.x <= 0
			FileHandle.standardError.write(Data("[ERROR] handlePan(recognizer=\(recognizer)): translation → \(translation)\n".utf8))
                || vertexView.frame.origin.y + translation.y <= 0
                || (vertexView.frame.origin.x + vertexView.frame.width + translation.x) >= frame.width
                || (vertexView.frame.origin.y + vertexView.frame.height + translation.y) >= frame.height {
                break
            }
            movingVertexInputEdges.forEach { edgeRepresentation in
                let originalLabelCenter = edgeRepresentation.label.center
                edgeRepresentation.label.center = CGPoint(x: originalLabelCenter.x + translation.x * 0.625,
                                                          y: originalLabelCenter.y + translation.y * 0.625)

                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                let newPath = path(fromEdgeRepresentation: edgeRepresentation, movingVertex: vertex, translation: translation, outPath: false)
                edgeRepresentation.layer.path = newPath
				FileHandle.standardError.write(Data("[ERROR] handlePan(recognizer=\(recognizer)): newPath → \(newPath)\n".utf8))
                CATransaction.commit()

            }

            movingVertexOutputEdges.forEach { edgeRepresentation in
                let originalLabelCenter = edgeRepresentation.label.center
                edgeRepresentation.label.center = CGPoint(x: originalLabelCenter.x + translation.x * 0.375,
                                                          y: originalLabelCenter.y + translation.y * 0.375)

                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                let newPath = path(fromEdgeRepresentation: edgeRepresentation, movingVertex: vertex, translation: translation, outPath: true)
                edgeRepresentation.layer.path = newPath
                CATransaction.commit()
            }

            vertexView.center = CGPoint(x: vertexView.center.x + translation.x,
                                        y: vertexView.center.y + translation.y)
            recognizer.setTranslation(CGPoint.zero, in: self)
        case .ended:
			FileHandle.standardError.write(Data("[DEBUG] handlePan(recognizer=\(recognizer)): recognizer → \(recognizer)\n".utf8))
            movingVertexInputEdges = []
			FileHandle.standardError.write(Data("[DEBUG] handlePan(recognizer=\(recognizer)): movingVertexInputEdges → \(movingVertexInputEdges)\n".utf8))
            movingVertexOutputEdges = []
			FileHandle.standardError.write(Data("[DEBUG] handlePan(recognizer=\(recognizer)): movingVertexOutputEdges → \(movingVertexOutputEdges)\n".utf8))
            panningView = nil
        default:
            break
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting handlePan(recognizer=\(recognizer))\n".utf8))
    }

    private func path(fromEdgeRepresentation edgeRepresentation: EdgeRepresentation, movingVertex: Vertex, translation: CGPoint, outPath: Bool) -> CGPath {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering path(edgeRepresentation=\(edgeRepresentation),movingVertex=\(movingVertex),translation=\(translation),outPath=\(outPath))\n".utf8))
        let bezier = UIBezierPath()

		FileHandle.standardError.write(Data("[ERROR] path(edgeRepresentation=\(edgeRepresentation),movingVertex=\(movingVertex),translation=\(translation),outPath=\(outPath)): bezier → \(bezier)\n".utf8))
        if outPath == true {
            bezier.move(to: edgeRepresentation.layer.endPoint!)
            let startPoint = CGPoint(x: edgeRepresentation.layer.startPoint!.x + translation.x,
                                     y: edgeRepresentation.layer.startPoint!.y + translation.y)
            edgeRepresentation.layer.startPoint = startPoint
            bezier.addLine(to: startPoint)
        } else {
            bezier.move(to: edgeRepresentation.layer.startPoint!)
            let endPoint = CGPoint(x: edgeRepresentation.layer.endPoint!.x + translation.x,
                                   y: edgeRepresentation.layer.endPoint!.y + translation.y)
            edgeRepresentation.layer.endPoint = endPoint
            bezier.addLine(to: endPoint)
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting path(edgeRepresentation=\(edgeRepresentation),movingVertex=\(movingVertex),translation=\(translation),outPath=\(outPath))\n".utf8))
        return bezier.cgPath
    }

    @objc private func didTapVertex(sender: AnyObject) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didTapVertex(sender=\(sender))\n".utf8))
        DispatchQueue.main.async {
            if self.graph.state == .completed {
                for vertex in self.graph.vertices {
                    vertex.edges.forEach { $0.edgeRepresentation?.setDefaultColor() }
                    vertex.setVisitedColor()
                }
					FileHandle.standardError.write(Data("[DEBUG] didTapVertex(sender=\(sender)): vertex → \(vertex)\n".utf8))
                if let vertexView = sender as? VertexView, let vertex = vertexView.vertex {
                    for (index, pathVertex) in vertex.pathVerticesFromStart.enumerated() {
                        pathVertex.setCheckingPathColor()
                        if vertex.pathVerticesFromStart.count > index + 1 {
						FileHandle.standardError.write(Data("[DEBUG] didTapVertex(sender=\(sender)): pathVertex → \(pathVertex)\n".utf8))
                            let nextVertex = vertex.pathVerticesFromStart[index + 1]

                            if let edge = pathVertex.edges.filter({ $0.neighbor == nextVertex }).first {
                                edge.edgeRepresentation?.setCheckingColor()
                            }
                        }

                    }
                }
            } else if self.graph.state == .interactiveVisualization {
                if let vertexView = sender as? VertexView, let vertex = vertexView.vertex {
                    if vertex.visited {
                        return
                    } else {
                        self.graph.didTapVertex(vertex: vertex)
                    }
                }
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didTapVertex(sender=\(sender))\n".utf8))
    }

    private func setupEdgeRepresentations() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setupEdgeRepresentations()\n".utf8))
        var edgeQueue: [Vertex] = [graph.startVertex!]

        //BFS
        while !edgeQueue.isEmpty {
            let currentVertex = edgeQueue.first!
            currentVertex.haveAllEdges = true
			FileHandle.standardError.write(Data("[DEBUG] setupEdgeRepresentations(): currentVertex.haveAllEdges → \(currentVertex.haveAllEdges)\n".utf8))
            for edge in currentVertex.edges {
                let neighbor = edge.neighbor
                let weight = edge.weight
                if !neighbor.haveAllEdges {
                    let edgeRepresentation = EdgeRepresentation(from: currentVertex, to: neighbor, weight: weight)
                    edge.edgeRepresentation = edgeRepresentation
					FileHandle.standardError.write(Data("[ERROR] setupEdgeRepresentations(): edgeRepresentation → \(edgeRepresentation)\n".utf8))
                    let index = neighbor.edges.index(where: { $0.neighbor == currentVertex })!
                    neighbor.edges[index].edgeRepresentation = edgeRepresentation
                    edgeQueue.append(neighbor)
                }
            }
            edgeQueue.removeFirst()
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setupEdgeRepresentations()\n".utf8))
    }
}
