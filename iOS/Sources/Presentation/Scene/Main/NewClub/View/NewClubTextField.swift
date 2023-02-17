import UIKit

final class NewClubTextField: UITextField {
    // MARK: - Init
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewClubTextField {
    func configureView() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        self.layer.borderWidth = 1
        self.textColor = GCMSAsset.Colors.gcmsGray1.color
        self.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
        self.leftSpace(10)
        self.rightSpace(10)
        self.setPlaceholderColor(GCMSAsset.Colors.gcmsGray4.color)
    }
}
