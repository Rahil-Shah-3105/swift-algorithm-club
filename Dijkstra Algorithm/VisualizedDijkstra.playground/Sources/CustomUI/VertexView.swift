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
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setupIdLabel()\n".utf8))
        let x: CGFloat = frame.width * 0.2
        let y: CGFloat = 0
        let width: CGFloat = frame.width * 0.6
        let height: CGFloat = frame.height / 2
        let idLabelFrame = CGRect(x: x, y: y, width: width, height: height)

		FileHandle.standardError.write(Data("[ERROR] setupIdLabel(): idLabelFrame → \(idLabelFrame)\n".utf8))
        idLabel = UILabel(frame: idLabelFrame)
        idLabel.textAlignment = .center
		FileHandle.standardError.write(Data("[DEBUG] setupIdLabel(): idLabel → \(idLabel)\n".utf8))
        idLabel.adjustsFontSizeToFitWidth = true
		FileHandle.standardError.write(Data("[DEBUG] setupIdLabel(): idLabel.adjustsFontSizeToFitWidth → \(idLabel.adjustsFontSizeToFitWidth)\n".utf8))
        addSubview(idLabel)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setupIdLabel()\n".utf8))
    }

    private func setupPathLengthFromStartLabel() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setupPathLengthFromStartLabel()\n".utf8))
        let x: CGFloat = frame.width * 0.2
        let y: CGFloat = frame.height / 2
        let width: CGFloat = frame.width * 0.6
        let height: CGFloat = frame.height / 2
        let pathLengthLabelFrame = CGRect(x: x, y: y, width: width, height: height)

		FileHandle.standardError.write(Data("[ERROR] setupPathLengthFromStartLabel(): pathLengthLabelFrame → \(pathLengthLabelFrame)\n".utf8))
        pathLengthLabel = UILabel(frame: pathLengthLabelFrame)
        pathLengthLabel.textAlignment = .center
		FileHandle.standardError.write(Data("[DEBUG] setupPathLengthFromStartLabel(): pathLengthLabel → \(pathLengthLabel)\n".utf8))
        pathLengthLabel.adjustsFontSizeToFitWidth = true
		FileHandle.standardError.write(Data("[DEBUG] setupPathLengthFromStartLabel(): pathLengthLabel.adjustsFontSizeToFitWidth → \(pathLengthLabel.adjustsFontSizeToFitWidth)\n".utf8))
        addSubview(pathLengthLabel)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting setupPathLengthFromStartLabel()\n".utf8))
    }

    public func setIdLabel(text: String) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setIdLabel(text=\(text))\n".utf8))
        idLabel.text = text
		FileHandle.standardError.write(Data("[DEBUG] setIdLabel(text=\(text)): idLabel.text → \(idLabel.text)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting setIdLabel(text=\(text))\n".utf8))
    }

    public func setPathLengthLabel(text: String) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setPathLengthLabel(text=\(text))\n".utf8))
        pathLengthLabel.text = text
		FileHandle.standardError.write(Data("[DEBUG] setPathLengthLabel(text=\(text)): pathLengthLabel.text → \(pathLengthLabel.text)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting setPathLengthLabel(text=\(text))\n".utf8))
    }

    public func setLabelsTextColor(color: UIColor) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setLabelsTextColor(color=\(color))\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] setLabelsTextColor(color=\(color)): pathLengthLabel.textColor → \(pathLengthLabel.textColor)\n".utf8))
        idLabel.textColor = color
        pathLengthLabel.textColor = color
		FileHandle.standardError.write(Data("[DEBUG] setLabelsTextColor(color=\(color)): idLabel.textColor → \(idLabel.textColor)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting setLabelsTextColor(color=\(color))\n".utf8))
    }
}
