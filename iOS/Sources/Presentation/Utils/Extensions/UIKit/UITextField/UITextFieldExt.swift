import UIKit
import SnapKit

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
        let spacer = UIView(frame: .init(x: 0, y: 0, width: space, height: self.frame.height))
        leftView = spacer
        leftViewMode = .always
    }
    func rightSpace(_ space: CGFloat) {
        let spacer = UIView(frame: .init(x: 0, y: 0, width: space, height: self.frame.height))
        rightView = spacer
        rightViewMode = .always
    }
    func addLeftImage(image: UIImage, space: CGFloat = 10) {
        let leftImage = UIImageView(image: image)
        let view = UIView()
        view.addSubViews(leftImage)
        leftImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(space)
            $0.centerY.equalToSuperview()
        }
        view.snp.makeConstraints {
            $0.size.equalTo(34)
        }
        self.leftView = view
        self.leftViewMode = .always
    }
    func addRightImage(image: UIImage, space: CGFloat = 10) {
        let rightImage = UIImageView(image: image)
        let view = UIView()
        view.addSubViews(rightImage)
        rightImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-space)
            $0.centerY.equalToSuperview()
        }
        view.snp.makeConstraints {
            $0.size.equalTo(34)
        }
        self.rightView = view
        self.rightViewMode = .always
    }
}
