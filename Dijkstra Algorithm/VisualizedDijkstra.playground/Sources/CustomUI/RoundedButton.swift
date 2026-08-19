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
		print(">>> Entering commonInit()")
        backgroundColor = graphColors.buttonsBackgroundColor
        titleLabel?.adjustsFontSizeToFitWidth = true
		print("commonInit(): backgroundColor → \(backgroundColor)")
		print("commonInit(): layer.cornerRadius → \(layer.cornerRadius)")
        layer.cornerRadius = 7
		print("<<< Exiting commonInit()")
    }
}
