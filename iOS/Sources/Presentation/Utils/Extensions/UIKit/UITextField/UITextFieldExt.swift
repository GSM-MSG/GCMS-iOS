import UIKit
extension UITextField {
    func setPlaceholderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
    func leftSpace(_ space: CGFloat) {
        let spacer = UIView()
        spacer.pin.width(space).height(of: self)
        leftView = spacer
        leftViewMode = .always
    }
    func rightSpace(_ space: CGFloat) {
        let spacer = UIView()
        spacer.pin.width(space).height(of: self)
        rightView = spacer
        rightViewMode = .always
    }
} 
