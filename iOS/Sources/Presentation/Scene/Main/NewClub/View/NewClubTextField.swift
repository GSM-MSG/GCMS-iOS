import UIKit

final class NewClubTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.layer.cornerRadius = 5
        self.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
