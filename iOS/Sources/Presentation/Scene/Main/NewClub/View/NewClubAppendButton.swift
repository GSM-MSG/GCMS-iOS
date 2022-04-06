import UIKit

final class NewClubAppendButton: UIButton {
    init() {
        super.init(frame: .zero)
        self.setImage(.init(systemName: "plus")?.tintColor(.white), for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
