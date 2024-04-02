import UIKit
import Configure

public class GCMSRadioButton: UIButton {
    public override var isSelected: Bool {
            didSet {
                super.isSelected = isSelected
            }
        }
    
    private func radioButton() -> UIImage {
        if isSelected {
            return GCMSAsset.Images.gcmsRadioButtonFill.image
        } else {
            return GCMSAsset.Images.gcmsRadioButton.image
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension GCMSRadioButton {
    func setup() {
        var button = UIButton()
        button.setImage(radioButton(), for: .normal)
    }
}
