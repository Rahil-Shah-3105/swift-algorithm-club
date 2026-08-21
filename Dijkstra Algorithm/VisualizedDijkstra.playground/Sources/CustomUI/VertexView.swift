import UIKit

public class VertexView: UIButton {

    public var vertex: Vertex?
    private var idLabel: UILabel!
    private var pathLengthLabel: UILabel!
    private var graphColors: GraphColors = GraphColors.sharedInstance

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override init(frame: CGRect) {
        precondition(frame.height == frame.width)
        precondition(frame.height >= 30)
        super.init(frame: frame)
        backgroundColor = graphColors.defaultVertexColor
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        setupIdLabel()
        setupPathLengthFromStartLabel()
    }

    private func setupIdLabel() {
		print(">>> Entering setupIdLabel()")
        let x: CGFloat = frame.width * 0.2
        let y: CGFloat = 0
        let width: CGFloat = frame.width * 0.6
        let height: CGFloat = frame.height / 2
        let idLabelFrame = CGRect(x: x, y: y, width: width, height: height)

		print("setupIdLabel(): idLabelFrame → \(idLabelFrame)")
        idLabel = UILabel(frame: idLabelFrame)
        idLabel.textAlignment = .center
		print("setupIdLabel(): idLabel → \(idLabel)")
		print("setupIdLabel(): idLabel.textAlignment → \(idLabel.textAlignment)")
		print("setupIdLabel(): idLabel.adjustsFontSizeToFitWidth → \(idLabel.adjustsFontSizeToFitWidth)")
        idLabel.adjustsFontSizeToFitWidth = true
        addSubview(idLabel)
		print("<<< Exiting setupIdLabel()")
    }

    private func setupPathLengthFromStartLabel() {
		print(">>> Entering setupPathLengthFromStartLabel()")
        let x: CGFloat = frame.width * 0.2
        let y: CGFloat = frame.height / 2
        let width: CGFloat = frame.width * 0.6
        let height: CGFloat = frame.height / 2
        let pathLengthLabelFrame = CGRect(x: x, y: y, width: width, height: height)

		print("setupPathLengthFromStartLabel(): pathLengthLabelFrame → \(pathLengthLabelFrame)")
        pathLengthLabel = UILabel(frame: pathLengthLabelFrame)
        pathLengthLabel.textAlignment = .center
		print("setupPathLengthFromStartLabel(): pathLengthLabel → \(pathLengthLabel)")
		print("setupPathLengthFromStartLabel(): pathLengthLabel.textAlignment → \(pathLengthLabel.textAlignment)")
		print("setupPathLengthFromStartLabel(): pathLengthLabel.adjustsFontSizeToFitWidth → \(pathLengthLabel.adjustsFontSizeToFitWidth)")
        pathLengthLabel.adjustsFontSizeToFitWidth = true
        addSubview(pathLengthLabel)
		print("<<< Exiting setupPathLengthFromStartLabel()")
    }

    public func setIdLabel(text: String) {
		print(">>> Entering setIdLabel(text=\(text))")
		print("setIdLabel(text=\(text)): idLabel.text → \(idLabel.text)")
        idLabel.text = text
    }

    public func setPathLengthLabel(text: String) {
		print(">>> Entering setPathLengthLabel(text=\(text))")
		print("setPathLengthLabel(text=\(text)): pathLengthLabel.text → \(pathLengthLabel.text)")
        pathLengthLabel.text = text
    }

    public func setLabelsTextColor(color: UIColor) {
		print(">>> Entering setLabelsTextColor(color=\(color))")
		print("setLabelsTextColor(color=\(color)): pathLengthLabel.textColor → \(pathLengthLabel.textColor)")
		print("setLabelsTextColor(color=\(color)): idLabel.textColor → \(idLabel.textColor)")
        idLabel.textColor = color
        pathLengthLabel.textColor = color
    }
}
