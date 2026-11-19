import Foundation
import UIKit

public protocol GraphDelegate: class {
    func willCompareVertices(startVertexPathLength: Double, edgePathLength: Double, endVertexPathLength: Double)
    func didFinishCompare()
    func didCompleteGraphParsing()
    func didTapWrongVertex()
    func didStop()
    func willStartVertexNeighborsChecking()
    func didFinishVertexNeighborsChecking()
}

public class Window: UIView, GraphDelegate {
    public var graphView: GraphView!

    private var topView: UIView!
    private var createGraphButton: RoundedButton!
    private var startVisualizationButton: RoundedButton!
    private var startInteractiveVisualizationButton: RoundedButton!
    private var startButton: UIButton!
    private var pauseButton: UIButton!
    private var stopButton: UIButton!
    private var comparisonLabel: UILabel!
    private var activityIndicator: UIActivityIndicatorView!
    private var graph: Graph!
    private var numberOfVertices: UInt!
    private var graphColors = GraphColors.sharedInstance

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        backgroundColor = graphColors.mainWindowBackgroundColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(graph: Graph) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configure(graph=\(graph))\n".utf8))
        self.graph = graph
        graph.createNewGraph()
        graph.delegate = self
		FileHandle.standardError.write(Data("[DEBUG] configure(graph=\(graph)): graph.delegate → \(graph.delegate)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] configure(graph=\(graph)): self.graph → \(self.graph)\n".utf8))
        let frame = CGRect(x: 10, y: 170, width: self.frame.width - 20, height: self.frame.height - 180)
        graphView = GraphView(frame: frame, graph: graph)
        
		FileHandle.standardError.write(Data("[DEBUG] configure(graph=\(graph)): graphView → \(graphView)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] configure(graph=\(graph)): frame → \(frame)\n".utf8))

        graphView.createNewGraph()
        addSubview(graphView)

        configureCreateGraphButton()
        configureStartVisualizationButton()
        configureStartInteractiveVisualizationButton()
        configureStartButton()
        configurePauseButton()
        configureStopButton()
        configureComparisonLabel()
        configureActivityIndicator()

        topView = UIView(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: 150))
        topView.backgroundColor = graphColors.topViewBackgroundColor
		FileHandle.standardError.write(Data("[DEBUG] configure(graph=\(graph)): topView.backgroundColor → \(topView.backgroundColor)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] configure(graph=\(graph)): topView → \(topView)\n".utf8))
        topView.layer.cornerRadius = 15
        addSubview(topView)

        topView.addSubview(createGraphButton)
        topView.addSubview(startVisualizationButton)
        topView.addSubview(startInteractiveVisualizationButton)
        topView.addSubview(startButton)
        topView.addSubview(pauseButton)
        topView.addSubview(stopButton)
        topView.addSubview(comparisonLabel)
        topView.addSubview(activityIndicator)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configure(graph=\(graph))\n".utf8))
    }

    private func configureCreateGraphButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configureCreateGraphButton()\n".utf8))
        let frame = CGRect(x: center.x - 200, y: 12, width: 100, height: 34)
        createGraphButton = RoundedButton(frame: frame)
        createGraphButton.setTitle("New graph", for: .normal)
        createGraphButton.addTarget(self, action: #selector(createGraphButtonTap), for: .touchUpInside)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configureCreateGraphButton()\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] configureCreateGraphButton(): frame → \(frame)\n".utf8))
    }

    private func configureStartVisualizationButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configureStartVisualizationButton()\n".utf8))
        let frame = CGRect(x: center.x - 50, y: 12, width: 100, height: 34)
        startVisualizationButton = RoundedButton(frame: frame)
        startVisualizationButton.setTitle("Auto", for: .normal)
        startVisualizationButton.addTarget(self, action: #selector(startVisualizationButtonDidTap), for: .touchUpInside)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configureStartVisualizationButton()\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] configureStartVisualizationButton(): frame → \(frame)\n".utf8))
    }

    private func configureStartInteractiveVisualizationButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configureStartInteractiveVisualizationButton()\n".utf8))
        let frame = CGRect(x: center.x + 100, y: 12, width: 100, height: 34)
        startInteractiveVisualizationButton = RoundedButton(frame: frame)
        startInteractiveVisualizationButton.setTitle("Interactive", for: .normal)
        startInteractiveVisualizationButton.addTarget(self, action: #selector(startInteractiveVisualizationButtonDidTap), for: .touchUpInside)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configureStartInteractiveVisualizationButton()\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] configureStartInteractiveVisualizationButton(): frame → \(frame)\n".utf8))
    }

    private func configureStartButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configureStartButton()\n".utf8))
        let frame = CGRect(x: center.x - 65, y: 56, width: 30, height: 30)
        startButton = UIButton(frame: frame)
        let playImage = UIImage(named: "Start.png")
        startButton.setImage(playImage, for: .normal)
        startButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] configureStartButton(): startButton → \(startButton)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configureStartButton()\n".utf8))
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
		FileHandle.standardError.write(Data("[ERROR] configureStartButton(): frame → \(frame)\n".utf8))
    }

    private func configurePauseButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configurePauseButton()\n".utf8))
        let frame = CGRect(x: center.x - 15, y: 56, width: 30, height: 30)
        pauseButton = UIButton(frame: frame)
        let pauseImage = UIImage(named: "Pause.png")
        pauseButton.setImage(pauseImage, for: .normal)
        pauseButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] configurePauseButton(): pauseButton → \(pauseButton)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configurePauseButton()\n".utf8))
        pauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
		FileHandle.standardError.write(Data("[ERROR] configurePauseButton(): frame → \(frame)\n".utf8))
    }

    private func configureStopButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configureStopButton()\n".utf8))
        let frame = CGRect(x: center.x + 35, y: 56, width: 30, height: 30)
        stopButton = UIButton(frame: frame)
        let stopImage = UIImage(named: "Stop.png")
        stopButton.setImage(stopImage, for: .normal)
        stopButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] configureStopButton(): stopButton → \(stopButton)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configureStopButton()\n".utf8))
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
		FileHandle.standardError.write(Data("[ERROR] configureStopButton(): frame → \(frame)\n".utf8))
    }

    private func configureComparisonLabel() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configureComparisonLabel()\n".utf8))
        let size = CGSize(width: 250, height: 42)
        let origin = CGPoint(x: center.x - 125, y: 96)
        let frame = CGRect(origin: origin, size: size)
        comparisonLabel = UILabel(frame: frame)
        comparisonLabel.textAlignment = .center
		FileHandle.standardError.write(Data("[ERROR] configureComparisonLabel(): origin → \(origin)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] configureComparisonLabel(): size → \(size)\n".utf8))
        comparisonLabel.text = "Have fun!"
		FileHandle.standardError.write(Data("[DEBUG] configureComparisonLabel(): comparisonLabel.text → \(comparisonLabel.text)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting configureComparisonLabel()\n".utf8))
    }

    private func configureActivityIndicator() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering configureActivityIndicator()\n".utf8))
        let size = CGSize(width: 50, height: 42)
        let origin = CGPoint(x: center.x - 25, y: 100)
        let activityIndicatorFrame = CGRect(origin: origin, size: size)
        activityIndicator = UIActivityIndicatorView(frame: activityIndicatorFrame)
        activityIndicator.style = .whiteLarge
		FileHandle.standardError.write(Data("[ERROR] configureActivityIndicator(): origin → \(origin)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] configureActivityIndicator(): size → \(size)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting configureActivityIndicator()\n".utf8))
    }

    @objc private func createGraphButtonTap() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering createGraphButtonTap()\n".utf8))
        comparisonLabel.text = ""
        graphView.removeGraph()
        graph.removeGraph()
        graph.createNewGraph()
        graphView.createNewGraph()
        graph.state = .initial
		FileHandle.standardError.write(Data("[DEBUG] createGraphButtonTap(): graph.state → \(graph.state)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] createGraphButtonTap(): comparisonLabel.text → \(comparisonLabel.text)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting createGraphButtonTap()\n".utf8))
    }

    @objc private func startVisualizationButtonDidTap() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering startVisualizationButtonDidTap()\n".utf8))
        comparisonLabel.text = ""
        pauseButton.isEnabled = true
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): pauseButton.isEnabled → \(pauseButton.isEnabled)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): comparisonLabel.text → \(comparisonLabel.text)\n".utf8))
        stopButton.isEnabled = true
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): stopButton.isEnabled → \(stopButton.isEnabled)\n".utf8))
        createGraphButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): createGraphButton.isEnabled → \(createGraphButton.isEnabled)\n".utf8))
        startVisualizationButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): startVisualizationButton.isEnabled → \(startVisualizationButton.isEnabled)\n".utf8))
        startInteractiveVisualizationButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): startInteractiveVisualizationButton.isEnabled → \(startInteractiveVisualizationButton.isEnabled)\n".utf8))
        createGraphButton.alpha = 0.5
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): createGraphButton.alpha → \(createGraphButton.alpha)\n".utf8))
        startVisualizationButton.alpha = 0.5
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): startVisualizationButton.alpha → \(startVisualizationButton.alpha)\n".utf8))
        startInteractiveVisualizationButton.alpha = 0.5
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): startInteractiveVisualizationButton.alpha → \(startInteractiveVisualizationButton.alpha)\n".utf8))

        if graph.state == .completed {
            graphView.reset()
            graph.reset()
        }
        graph.state = .autoVisualization
		FileHandle.standardError.write(Data("[DEBUG] startVisualizationButtonDidTap(): graph.state → \(graph.state)\n".utf8))
        DispatchQueue.global(qos: .background).async {
            self.graph.findShortestPathsWithVisualization {
                self.graph.state = .completed

                DispatchQueue.main.async {
                    self.startButton.isEnabled = false
                    self.pauseButton.isEnabled = false
                    self.stopButton.isEnabled = false
                    self.createGraphButton.isEnabled = true
                    self.startVisualizationButton.isEnabled = true
                    self.startInteractiveVisualizationButton.isEnabled = true
                    self.createGraphButton.alpha = 1
                    self.startVisualizationButton.alpha = 1
                    self.startInteractiveVisualizationButton.alpha = 1
                    self.comparisonLabel.text = "Completed!"
                }
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting startVisualizationButtonDidTap()\n".utf8))
    }

    @objc private func startInteractiveVisualizationButtonDidTap() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering startInteractiveVisualizationButtonDidTap()\n".utf8))
        comparisonLabel.text = ""
        pauseButton.isEnabled = true
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): pauseButton.isEnabled → \(pauseButton.isEnabled)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): comparisonLabel.text → \(comparisonLabel.text)\n".utf8))
        stopButton.isEnabled = true
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): stopButton.isEnabled → \(stopButton.isEnabled)\n".utf8))
        createGraphButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): createGraphButton.isEnabled → \(createGraphButton.isEnabled)\n".utf8))
        startVisualizationButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): startVisualizationButton.isEnabled → \(startVisualizationButton.isEnabled)\n".utf8))
        startInteractiveVisualizationButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): startInteractiveVisualizationButton.isEnabled → \(startInteractiveVisualizationButton.isEnabled)\n".utf8))
        createGraphButton.alpha = 0.5
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): createGraphButton.alpha → \(createGraphButton.alpha)\n".utf8))
        startVisualizationButton.alpha = 0.5
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): startVisualizationButton.alpha → \(startVisualizationButton.alpha)\n".utf8))
        startInteractiveVisualizationButton.alpha = 0.5
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): startInteractiveVisualizationButton.alpha → \(startInteractiveVisualizationButton.alpha)\n".utf8))

        if graph.state == .completed {
            graphView.reset()
            graph.reset()
        }

        guard let startVertex = graph.startVertex else {
            assertionFailure("startVertex is nil")
            return
        }
        startVertex.pathLengthFromStart = 0
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): startVertex.pathLengthFromStart → \(startVertex.pathLengthFromStart)\n".utf8))
        startVertex.pathVerticesFromStart.append(startVertex)
        graph.state = .parsing
		FileHandle.standardError.write(Data("[DEBUG] startInteractiveVisualizationButtonDidTap(): graph.state → \(graph.state)\n".utf8))
        graph.parseNeighborsFor(vertex: startVertex) {
            self.graph.state = .interactiveVisualization
            DispatchQueue.main.async {
                self.comparisonLabel.text = "Pick next vertex"
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting startInteractiveVisualizationButtonDidTap()\n".utf8))
    }

    @objc private func didTapStartButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didTapStartButton()\n".utf8))
        startButton.isEnabled = false
        pauseButton.isEnabled = true
		FileHandle.standardError.write(Data("[DEBUG] didTapStartButton(): pauseButton.isEnabled → \(pauseButton.isEnabled)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] didTapStartButton(): startButton.isEnabled → \(startButton.isEnabled)\n".utf8))
        DispatchQueue.global(qos: .utility).async {
            self.graph.pauseVisualization = false
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didTapStartButton()\n".utf8))
    }

    @objc private func didTapPauseButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didTapPauseButton()\n".utf8))
        startButton.isEnabled = true
        pauseButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] didTapPauseButton(): pauseButton.isEnabled → \(pauseButton.isEnabled)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] didTapPauseButton(): startButton.isEnabled → \(startButton.isEnabled)\n".utf8))
        DispatchQueue.global(qos: .utility).async {
            self.graph.pauseVisualization = true
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didTapPauseButton()\n".utf8))
    }

    @objc private func didTapStopButton() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didTapStopButton()\n".utf8))
        startButton.isEnabled = false
        pauseButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] didTapStopButton(): pauseButton.isEnabled → \(pauseButton.isEnabled)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] didTapStopButton(): startButton.isEnabled → \(startButton.isEnabled)\n".utf8))
        comparisonLabel.text = ""
		FileHandle.standardError.write(Data("[DEBUG] didTapStopButton(): comparisonLabel.text → \(comparisonLabel.text)\n".utf8))
        activityIndicator.startAnimating()
        if graph.state == .parsing || graph.state == .autoVisualization {
            graph.stopVisualization = true
        } else if graph.state == .interactiveVisualization {
            didStop()
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didTapStopButton()\n".utf8))
    }

    private func setButtonsToInitialState() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setButtonsToInitialState()\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): startInteractiveVisualizationButton.alpha → \(startInteractiveVisualizationButton.alpha)\n".utf8))
        createGraphButton.isEnabled = true
        startVisualizationButton.isEnabled = true
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): startVisualizationButton.isEnabled → \(startVisualizationButton.isEnabled)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): createGraphButton.isEnabled → \(createGraphButton.isEnabled)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting setButtonsToInitialState()\n".utf8))
        startInteractiveVisualizationButton.isEnabled = true
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): startInteractiveVisualizationButton.isEnabled → \(startInteractiveVisualizationButton.isEnabled)\n".utf8))
        startButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): startButton.isEnabled → \(startButton.isEnabled)\n".utf8))
        pauseButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): pauseButton.isEnabled → \(pauseButton.isEnabled)\n".utf8))
        stopButton.isEnabled = false
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): stopButton.isEnabled → \(stopButton.isEnabled)\n".utf8))
        createGraphButton.alpha = 1
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): createGraphButton.alpha → \(createGraphButton.alpha)\n".utf8))
        startVisualizationButton.alpha = 1
		FileHandle.standardError.write(Data("[DEBUG] setButtonsToInitialState(): startVisualizationButton.alpha → \(startVisualizationButton.alpha)\n".utf8))
        startInteractiveVisualizationButton.alpha = 1
    }

    private func showError(error: String) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering showError(error=\(error))\n".utf8))
        DispatchQueue.main.async {
            let size = CGSize(width: 250, height: 42)
            let origin = CGPoint(x: self.topView.center.x - 125, y: 96)
            let frame = CGRect(origin: origin, size: size)
            let errorView = ErrorView(frame: frame)
            errorView.setText(text: error)
            self.topView.addSubview(errorView)
            UIView.animate(withDuration: 2, animations: {
			FileHandle.standardError.write(Data("[DEBUG] showError(error=\(error)): errorView → \(errorView)\n".utf8))
			FileHandle.standardError.write(Data("[ERROR] showError(error=\(error)): size → \(size)\n".utf8))
                errorView.alpha = 0
            }, completion: { _ in
                errorView.removeFromSuperview()
            })
        }
			FileHandle.standardError.write(Data("[DEBUG] showError(error=\(error)): errorView.alpha → \(errorView.alpha)\n".utf8))
		FileHandle.standardError.write(Data("[WARN] <<< Exiting showError(error=\(error))\n".utf8))
    }

    // MARK: GraphDelegate
    public func didCompleteGraphParsing() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didCompleteGraphParsing()\n".utf8))
        graph.state = .completed
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didCompleteGraphParsing()\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] didCompleteGraphParsing(): graph.state → \(graph.state)\n".utf8))
        setButtonsToInitialState()
        comparisonLabel.text = "Completed!"
		FileHandle.standardError.write(Data("[DEBUG] didCompleteGraphParsing(): comparisonLabel.text → \(comparisonLabel.text)\n".utf8))
    }

    public func didTapWrongVertex() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didTapWrongVertex()\n".utf8))
        if !subviews.contains { $0 is ErrorView } {
            showError(error: "You have picked wrong next vertex")
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didTapWrongVertex()\n".utf8))
    }

    public func willCompareVertices(startVertexPathLength: Double, edgePathLength: Double, endVertexPathLength: Double) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering willCompareVertices(startVertexPathLength=\(startVertexPathLength),edgePathLength=\(edgePathLength),endVertexPathLength=\(endVertexPathLength))\n".utf8))
        DispatchQueue.main.async {
            if startVertexPathLength + edgePathLength < endVertexPathLength {
                self.comparisonLabel.text = "\(startVertexPathLength) + \(edgePathLength) < \(endVertexPathLength) 👍"
            } else {
                self.comparisonLabel.text = "\(startVertexPathLength) + \(edgePathLength) >= \(endVertexPathLength) 👎"
            }
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting willCompareVertices(startVertexPathLength=\(startVertexPathLength),edgePathLength=\(edgePathLength),endVertexPathLength=\(endVertexPathLength))\n".utf8))
    }

    public func didFinishCompare() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didFinishCompare()\n".utf8))
        DispatchQueue.main.async {
            self.comparisonLabel.text = ""
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didFinishCompare()\n".utf8))
    }

    public func didStop() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didStop()\n".utf8))
        graph.state = .initial
        graph.stopVisualization = false
		FileHandle.standardError.write(Data("[DEBUG] didStop(): graph.stopVisualization → \(graph.stopVisualization)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] didStop(): graph.state → \(graph.state)\n".utf8))
        graph.pauseVisualization = false
		FileHandle.standardError.write(Data("[DEBUG] didStop(): graph.pauseVisualization → \(graph.pauseVisualization)\n".utf8))
        graphView.reset()
        graph.reset()
        setButtonsToInitialState()
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didStop()\n".utf8))
        activityIndicator.stopAnimating()
    }

    public func willStartVertexNeighborsChecking() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering willStartVertexNeighborsChecking()\n".utf8))
        DispatchQueue.main.async {
            self.comparisonLabel.text = ""
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting willStartVertexNeighborsChecking()\n".utf8))
    }

    public func didFinishVertexNeighborsChecking() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering didFinishVertexNeighborsChecking()\n".utf8))
        DispatchQueue.main.async {
            self.comparisonLabel.text = "Pick next vertex"
        }
		FileHandle.standardError.write(Data("[WARN] <<< Exiting didFinishVertexNeighborsChecking()\n".utf8))
    }
}
