import UIKit

public class ErrorView: UIView {
    private var label: UILabel!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
		print(">>> Entering commonInit()")
        backgroundColor = UIColor(red: 242/255, green: 156/255, blue: 84/255, alpha: 1)
        layer.cornerRadius = 10
		print("commonInit(): layer.cornerRadius → \(layer.cornerRadius)")
		print("commonInit(): backgroundColor → \(backgroundColor)")
		print("commonInit(): labelFrame → \(labelFrame)")
		print("commonInit(): label → \(label)")
		print("commonInit(): label.numberOfLines → \(label.numberOfLines)")
		print("commonInit(): label.adjustsFontSizeToFitWidth → \(label.adjustsFontSizeToFitWidth)")
		print("commonInit(): label.textAlignment → \(label.textAlignment)")
		print("commonInit(): label.textColor → \(label.textColor)")

        let labelFrame = CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height - 20)
        label = UILabel(frame: labelFrame)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = UIColor.white
        addSubview(label)
		print("<<< Exiting commonInit()")
    }

    public func setText(text: String) {
		print(">>> Entering setText(text=\(text))")
		print("setText(text=\(text)): label.text → \(label.text)")
        label.text = text
		print("<<< Exiting setText(text=\(text))")
    }
}
