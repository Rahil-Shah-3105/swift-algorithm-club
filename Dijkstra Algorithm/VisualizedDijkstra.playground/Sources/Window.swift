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
	print(">>> Entering didFinishVertexNeighborsChecking()")
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
	print("<<< Exiting didFinishVertexNeighborsChecking()")

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        backgroundColor = graphColors.mainWindowBackgroundColor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(graph: Graph) {
		print(">>> Entering configure(graph=\(graph))")
        self.graph = graph
        graph.createNewGraph()
        graph.delegate = self
		print("configure(graph=\(graph)): self.graph → \(self.graph)")
		print("configure(graph=\(graph)): graph.delegate → \(graph.delegate)")
		print("configure(graph=\(graph)): frame → \(frame)")
		print("configure(graph=\(graph)): graphView → \(graphView)")
        let frame = CGRect(x: 10, y: 170, width: self.frame.width - 20, height: self.frame.height - 180)
        graphView = GraphView(frame: frame, graph: graph)
        

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
		print("configure(graph=\(graph)): topView → \(topView)")
		print("configure(graph=\(graph)): topView.backgroundColor → \(topView.backgroundColor)")
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
		print("<<< Exiting configure(graph=\(graph))")
    }

    private func configureCreateGraphButton() {
		print(">>> Entering configureCreateGraphButton()")
		print("configureCreateGraphButton(): createGraphButton → \(createGraphButton)")
        let frame = CGRect(x: center.x - 200, y: 12, width: 100, height: 34)
        createGraphButton = RoundedButton(frame: frame)
        createGraphButton.setTitle("New graph", for: .normal)
        createGraphButton.addTarget(self, action: #selector(createGraphButtonTap), for: .touchUpInside)
		print("<<< Exiting configureCreateGraphButton()")
    }

    private func configureStartVisualizationButton() {
		print(">>> Entering configureStartVisualizationButton()")
		print("configureStartVisualizationButton(): startVisualizationButton → \(startVisualizationButton)")
        let frame = CGRect(x: center.x - 50, y: 12, width: 100, height: 34)
        startVisualizationButton = RoundedButton(frame: frame)
        startVisualizationButton.setTitle("Auto", for: .normal)
        startVisualizationButton.addTarget(self, action: #selector(startVisualizationButtonDidTap), for: .touchUpInside)
		print("<<< Exiting configureStartVisualizationButton()")
    }

    private func configureStartInteractiveVisualizationButton() {
		print(">>> Entering configureStartInteractiveVisualizationButton()")
		print("configureStartInteractiveVisualizationButton(): startInteractiveVisualizationButton → \(startInteractiveVisualizationButton)")
        let frame = CGRect(x: center.x + 100, y: 12, width: 100, height: 34)
        startInteractiveVisualizationButton = RoundedButton(frame: frame)
        startInteractiveVisualizationButton.setTitle("Interactive", for: .normal)
        startInteractiveVisualizationButton.addTarget(self, action: #selector(startInteractiveVisualizationButtonDidTap), for: .touchUpInside)
		print("<<< Exiting configureStartInteractiveVisualizationButton()")
    }

    private func configureStartButton() {
		print(">>> Entering configureStartButton()")
		print("configureStartButton(): startButton → \(startButton)")
		print("configureStartButton(): playImage → \(playImage)")
        let frame = CGRect(x: center.x - 65, y: 56, width: 30, height: 30)
        startButton = UIButton(frame: frame)
        let playImage = UIImage(named: "Start.png")
        startButton.setImage(playImage, for: .normal)
        startButton.isEnabled = false
		print("<<< Exiting configureStartButton()")
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
		print("configureStartButton(): frame → \(frame)")
    }

    private func configurePauseButton() {
		print(">>> Entering configurePauseButton()")
		print("configurePauseButton(): pauseButton → \(pauseButton)")
		print("configurePauseButton(): pauseImage → \(pauseImage)")
        let frame = CGRect(x: center.x - 15, y: 56, width: 30, height: 30)
        pauseButton = UIButton(frame: frame)
        let pauseImage = UIImage(named: "Pause.png")
        pauseButton.setImage(pauseImage, for: .normal)
        pauseButton.isEnabled = false
		print("<<< Exiting configurePauseButton()")
        pauseButton.addTarget(self, action: #selector(didTapPauseButton), for: .touchUpInside)
		print("configurePauseButton(): frame → \(frame)")
    }

    private func configureStopButton() {
		print(">>> Entering configureStopButton()")
		print("configureStopButton(): stopButton → \(stopButton)")
		print("configureStopButton(): stopImage → \(stopImage)")
        let frame = CGRect(x: center.x + 35, y: 56, width: 30, height: 30)
        stopButton = UIButton(frame: frame)
        let stopImage = UIImage(named: "Stop.png")
        stopButton.setImage(stopImage, for: .normal)
        stopButton.isEnabled = false
		print("<<< Exiting configureStopButton()")
        stopButton.addTarget(self, action: #selector(didTapStopButton), for: .touchUpInside)
		print("configureStopButton(): frame → \(frame)")
    }

    private func configureComparisonLabel() {
		print(">>> Entering configureComparisonLabel()")
		print("configureComparisonLabel(): size → \(size)")
		print("configureComparisonLabel(): origin → \(origin)")
		print("configureComparisonLabel(): frame → \(frame)")
		print("configureComparisonLabel(): comparisonLabel → \(comparisonLabel)")
		print("configureComparisonLabel(): comparisonLabel.textAlignment → \(comparisonLabel.textAlignment)")
		print("configureComparisonLabel(): comparisonLabel.text → \(comparisonLabel.text)")
        let size = CGSize(width: 250, height: 42)
        let origin = CGPoint(x: center.x - 125, y: 96)
        let frame = CGRect(origin: origin, size: size)
        comparisonLabel = UILabel(frame: frame)
        comparisonLabel.textAlignment = .center
        comparisonLabel.text = "Have fun!"
    }

    private func configureActivityIndicator() {
		print(">>> Entering configureActivityIndicator()")
		print("configureActivityIndicator(): size → \(size)")
		print("configureActivityIndicator(): origin → \(origin)")
		print("configureActivityIndicator(): activityIndicatorFrame → \(activityIndicatorFrame)")
		print("configureActivityIndicator(): activityIndicator → \(activityIndicator)")
		print("configureActivityIndicator(): activityIndicator.style → \(activityIndicator.style)")
        let size = CGSize(width: 50, height: 42)
        let origin = CGPoint(x: center.x - 25, y: 100)
        let activityIndicatorFrame = CGRect(origin: origin, size: size)
        activityIndicator = UIActivityIndicatorView(frame: activityIndicatorFrame)
        activityIndicator.style = .whiteLarge
    }

    @objc private func createGraphButtonTap() {
		print(">>> Entering createGraphButtonTap()")
        comparisonLabel.text = ""
        graphView.removeGraph()
        graph.removeGraph()
        graph.createNewGraph()
        graphView.createNewGraph()
        graph.state = .initial
		print("createGraphButtonTap(): comparisonLabel.text → \(comparisonLabel.text)")
		print("<<< Exiting createGraphButtonTap()")
    }

    @objc private func startVisualizationButtonDidTap() {
		print(">>> Entering startVisualizationButtonDidTap()")
        comparisonLabel.text = ""
        pauseButton.isEnabled = true
		print("startVisualizationButtonDidTap(): pauseButton.isEnabled → \(pauseButton.isEnabled)")
		print("startVisualizationButtonDidTap(): stopButton.isEnabled → \(stopButton.isEnabled)")
		print("startVisualizationButtonDidTap(): createGraphButton.isEnabled → \(createGraphButton.isEnabled)")
		print("startVisualizationButtonDidTap(): startVisualizationButton.isEnabled → \(startVisualizationButton.isEnabled)")
		print("startVisualizationButtonDidTap(): startInteractiveVisualizationButton.isEnabled → \(startInteractiveVisualizationButton.isEnabled)")
		print("startVisualizationButtonDidTap(): createGraphButton.alpha → \(createGraphButton.alpha)")
		print("startVisualizationButtonDidTap(): startVisualizationButton.alpha → \(startVisualizationButton.alpha)")
		print("startVisualizationButtonDidTap(): startInteractiveVisualizationButton.alpha → \(startInteractiveVisualizationButton.alpha)")
		print("startVisualizationButtonDidTap(): comparisonLabel.text → \(comparisonLabel.text)")
        stopButton.isEnabled = true
        createGraphButton.isEnabled = false
        startVisualizationButton.isEnabled = false
        startInteractiveVisualizationButton.isEnabled = false
        createGraphButton.alpha = 0.5
        startVisualizationButton.alpha = 0.5
        startInteractiveVisualizationButton.alpha = 0.5

        if graph.state == .completed {
            graphView.reset()
            graph.reset()
        }
        graph.state = .autoVisualization
		print("startVisualizationButtonDidTap(): graph.state → \(graph.state)")
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
		print("<<< Exiting startVisualizationButtonDidTap()")
    }

    @objc private func startInteractiveVisualizationButtonDidTap() {
		print(">>> Entering startInteractiveVisualizationButtonDidTap()")
        comparisonLabel.text = ""
        pauseButton.isEnabled = true
		print("startInteractiveVisualizationButtonDidTap(): pauseButton.isEnabled → \(pauseButton.isEnabled)")
		print("startInteractiveVisualizationButtonDidTap(): stopButton.isEnabled → \(stopButton.isEnabled)")
		print("startInteractiveVisualizationButtonDidTap(): createGraphButton.isEnabled → \(createGraphButton.isEnabled)")
		print("startInteractiveVisualizationButtonDidTap(): startVisualizationButton.isEnabled → \(startVisualizationButton.isEnabled)")
		print("startInteractiveVisualizationButtonDidTap(): startInteractiveVisualizationButton.isEnabled → \(startInteractiveVisualizationButton.isEnabled)")
		print("startInteractiveVisualizationButtonDidTap(): createGraphButton.alpha → \(createGraphButton.alpha)")
		print("startInteractiveVisualizationButtonDidTap(): startVisualizationButton.alpha → \(startVisualizationButton.alpha)")
		print("startInteractiveVisualizationButtonDidTap(): startInteractiveVisualizationButton.alpha → \(startInteractiveVisualizationButton.alpha)")
		print("startInteractiveVisualizationButtonDidTap(): comparisonLabel.text → \(comparisonLabel.text)")
        stopButton.isEnabled = true
        createGraphButton.isEnabled = false
        startVisualizationButton.isEnabled = false
        startInteractiveVisualizationButton.isEnabled = false
        createGraphButton.alpha = 0.5
        startVisualizationButton.alpha = 0.5
        startInteractiveVisualizationButton.alpha = 0.5

        if graph.state == .completed {
            graphView.reset()
            graph.reset()
        }

        guard let startVertex = graph.startVertex else {
            assertionFailure("startVertex is nil")
            return
        }
        startVertex.pathLengthFromStart = 0
		print("startInteractiveVisualizationButtonDidTap(): startVertex.pathLengthFromStart → \(startVertex.pathLengthFromStart)")
        startVertex.pathVerticesFromStart.append(startVertex)
        graph.state = .parsing
		print("startInteractiveVisualizationButtonDidTap(): graph.state → \(graph.state)")
        graph.parseNeighborsFor(vertex: startVertex) {
            self.graph.state = .interactiveVisualization
            DispatchQueue.main.async {
                self.comparisonLabel.text = "Pick next vertex"
            }
        }
		print("<<< Exiting startInteractiveVisualizationButtonDidTap()")
    }

    @objc private func didTapStartButton() {
		print(">>> Entering didTapStartButton()")
        startButton.isEnabled = false
        pauseButton.isEnabled = true
		print("didTapStartButton(): pauseButton.isEnabled → \(pauseButton.isEnabled)")
		print("didTapStartButton(): startButton.isEnabled → \(startButton.isEnabled)")
        DispatchQueue.global(qos: .utility).async {
            self.graph.pauseVisualization = false
        }
		print("<<< Exiting didTapStartButton()")
    }

    @objc private func didTapPauseButton() {
		print(">>> Entering didTapPauseButton()")
        startButton.isEnabled = true
        pauseButton.isEnabled = false
		print("didTapPauseButton(): pauseButton.isEnabled → \(pauseButton.isEnabled)")
		print("didTapPauseButton(): startButton.isEnabled → \(startButton.isEnabled)")
        DispatchQueue.global(qos: .utility).async {
            self.graph.pauseVisualization = true
        }
		print("<<< Exiting didTapPauseButton()")
    }

    @objc private func didTapStopButton() {
		print(">>> Entering didTapStopButton()")
        startButton.isEnabled = false
        pauseButton.isEnabled = false
		print("didTapStopButton(): pauseButton.isEnabled → \(pauseButton.isEnabled)")
		print("didTapStopButton(): comparisonLabel.text → \(comparisonLabel.text)")
		print("didTapStopButton(): startButton.isEnabled → \(startButton.isEnabled)")
        comparisonLabel.text = ""
        activityIndicator.startAnimating()
        if graph.state == .parsing || graph.state == .autoVisualization {
            graph.stopVisualization = true
        } else if graph.state == .interactiveVisualization {
            didStop()
        }
		print("<<< Exiting didTapStopButton()")
    }

    private func setButtonsToInitialState() {
		print(">>> Entering setButtonsToInitialState()")
		print("setButtonsToInitialState(): startInteractiveVisualizationButton.alpha → \(startInteractiveVisualizationButton.alpha)")
		print("setButtonsToInitialState(): startVisualizationButton.isEnabled → \(startVisualizationButton.isEnabled)")
		print("setButtonsToInitialState(): startInteractiveVisualizationButton.isEnabled → \(startInteractiveVisualizationButton.isEnabled)")
		print("setButtonsToInitialState(): startButton.isEnabled → \(startButton.isEnabled)")
		print("setButtonsToInitialState(): pauseButton.isEnabled → \(pauseButton.isEnabled)")
		print("setButtonsToInitialState(): stopButton.isEnabled → \(stopButton.isEnabled)")
		print("setButtonsToInitialState(): createGraphButton.alpha → \(createGraphButton.alpha)")
		print("setButtonsToInitialState(): startVisualizationButton.alpha → \(startVisualizationButton.alpha)")
		print("setButtonsToInitialState(): createGraphButton.isEnabled → \(createGraphButton.isEnabled)")
        createGraphButton.isEnabled = true
        startVisualizationButton.isEnabled = true
        startInteractiveVisualizationButton.isEnabled = true
        startButton.isEnabled = false
        pauseButton.isEnabled = false
        stopButton.isEnabled = false
        createGraphButton.alpha = 1
        startVisualizationButton.alpha = 1
        startInteractiveVisualizationButton.alpha = 1
    }

    private func showError(error: String) {
		print(">>> Entering showError(error=\(error))")
        DispatchQueue.main.async {
            let size = CGSize(width: 250, height: 42)
            let origin = CGPoint(x: self.topView.center.x - 125, y: 96)
            let frame = CGRect(origin: origin, size: size)
            let errorView = ErrorView(frame: frame)
            errorView.setText(text: error)
            self.topView.addSubview(errorView)
            UIView.animate(withDuration: 2, animations: {
			print("showError(error=\(error)): size → \(size)")
			print("showError(error=\(error)): origin → \(origin)")
			print("showError(error=\(error)): frame → \(frame)")
                errorView.alpha = 0
            }, completion: { _ in
                errorView.removeFromSuperview()
            })
        }
			print("showError(error=\(error)): errorView.alpha → \(errorView.alpha)")
		print("<<< Exiting showError(error=\(error))")
    }

    // MARK: GraphDelegate
    public func didCompleteGraphParsing() {
		print(">>> Entering didCompleteGraphParsing()")
		print("didCompleteGraphParsing(): graph.state → \(graph.state)")
		print("didCompleteGraphParsing(): comparisonLabel.text → \(comparisonLabel.text)")
        graph.state = .completed
		print("<<< Exiting didCompleteGraphParsing()")
        setButtonsToInitialState()
        comparisonLabel.text = "Completed!"
    }

    public func didTapWrongVertex() {
		print(">>> Entering didTapWrongVertex()")
        if !subviews.contains { $0 is ErrorView } {
            showError(error: "You have picked wrong next vertex")
        }
		print("<<< Exiting didTapWrongVertex()")
    }

    public func willCompareVertices(startVertexPathLength: Double, edgePathLength: Double, endVertexPathLength: Double) {
		print(">>> Entering willCompareVertices(startVertexPathLength=\(startVertexPathLength),edgePathLength=\(edgePathLength),endVertexPathLength=\(endVertexPathLength))")
        DispatchQueue.main.async {
            if startVertexPathLength + edgePathLength < endVertexPathLength {
                self.comparisonLabel.text = "\(startVertexPathLength) + \(edgePathLength) < \(endVertexPathLength) 👍"
            } else {
                self.comparisonLabel.text = "\(startVertexPathLength) + \(edgePathLength) >= \(endVertexPathLength) 👎"
            }
        }
		print("<<< Exiting willCompareVertices(startVertexPathLength=\(startVertexPathLength),edgePathLength=\(edgePathLength),endVertexPathLength=\(endVertexPathLength))")
    }

    public func didFinishCompare() {
		print(">>> Entering didFinishCompare()")
        DispatchQueue.main.async {
            self.comparisonLabel.text = ""
        }
		print("<<< Exiting didFinishCompare()")
    }

    public func didStop() {
		print(">>> Entering didStop()")
        graph.state = .initial
        graph.stopVisualization = false
		print("didStop(): graph.stopVisualization → \(graph.stopVisualization)")
		print("didStop(): graph.pauseVisualization → \(graph.pauseVisualization)")
		print("didStop(): graph.state → \(graph.state)")
        graph.pauseVisualization = false
        graphView.reset()
        graph.reset()
        setButtonsToInitialState()
		print("<<< Exiting didStop()")
        activityIndicator.stopAnimating()
    }

    public func willStartVertexNeighborsChecking() {
		print(">>> Entering willStartVertexNeighborsChecking()")
        DispatchQueue.main.async {
            self.comparisonLabel.text = ""
        }
		print("<<< Exiting willStartVertexNeighborsChecking()")
    }

    public func didFinishVertexNeighborsChecking() {
        DispatchQueue.main.async {
            self.comparisonLabel.text = "Pick next vertex"
        }
    }
}
