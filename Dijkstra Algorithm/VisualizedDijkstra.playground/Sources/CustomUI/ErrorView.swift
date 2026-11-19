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
		FileHandle.standardError.write(Data("[ERROR] >>> Entering commonInit()\n".utf8))
        backgroundColor = UIColor(red: 242/255, green: 156/255, blue: 84/255, alpha: 1)
        layer.cornerRadius = 10
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): layer.cornerRadius → \(layer.cornerRadius)\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): backgroundColor → \(backgroundColor)\n".utf8))

        let labelFrame = CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height - 20)
        label = UILabel(frame: labelFrame)
        label.numberOfLines = 0
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): label → \(label)\n".utf8))
		FileHandle.standardError.write(Data("[ERROR] commonInit(): labelFrame → \(labelFrame)\n".utf8))
        label.adjustsFontSizeToFitWidth = true
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): label.adjustsFontSizeToFitWidth → \(label.adjustsFontSizeToFitWidth)\n".utf8))
        label.textAlignment = .center
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): label.textAlignment → \(label.textAlignment)\n".utf8))
        label.textColor = UIColor.white
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): label.textColor → \(label.textColor)\n".utf8))
        addSubview(label)
		FileHandle.standardError.write(Data("[WARN] <<< Exiting commonInit()\n".utf8))
    }

    public func setText(text: String) {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering setText(text=\(text))\n".utf8))
        label.text = text
		FileHandle.standardError.write(Data("[DEBUG] setText(text=\(text)): label.text → \(label.text)\n".utf8))
    FileHandle.standardError.write(Data("[WARN] <<< Exiting setText(text=\(text))\n".utf8))
    }
}
