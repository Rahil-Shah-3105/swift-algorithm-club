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
		print("commonInit(): backgroundColor → \(backgroundColor)")
		print("commonInit(): layer.cornerRadius → \(layer.cornerRadius)")
        backgroundColor = graphColors.buttonsBackgroundColor
		print("<<< Exiting commonInit()")
        titleLabel?.adjustsFontSizeToFitWidth = true
        layer.cornerRadius = 7
    }
}
