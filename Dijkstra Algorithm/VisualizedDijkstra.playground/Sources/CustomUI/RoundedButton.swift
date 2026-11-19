import UIKit

public class RoundedButton: UIButton {
    private var graphColors: GraphColors = GraphColors.sharedInstance
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
		FileHandle.standardError.write(Data("[ERROR] >>> Entering commonInit()\n".utf8))
        backgroundColor = graphColors.buttonsBackgroundColor
		FileHandle.standardError.write(Data("[WARN] <<< Exiting commonInit()\n".utf8))
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): backgroundColor → \(backgroundColor)\n".utf8))
        titleLabel?.adjustsFontSizeToFitWidth = true
        layer.cornerRadius = 7
		FileHandle.standardError.write(Data("[DEBUG] commonInit(): layer.cornerRadius → \(layer.cornerRadius)\n".utf8))
    }
}
