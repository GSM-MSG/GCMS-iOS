import UIKit
import PinLayout
import Service
import Kingfisher

final class UserHorizontalView: UIView {
    // MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    private let nameLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayoutSubviews()
    }
    
    // MARK: - UI
    init() {
        super.init(frame: .zero)
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(user: User) {
        profileImageView.kf.setImage(with: URL(string: user.picture) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        nameLabel.text = user.name
        nameLabel.sizeToFit()
    }
}

// MARK: - UI
private extension UserHorizontalView {
    func addView() {
        addSubViews(profileImageView, nameLabel)
    }
    func setLayoutSubviews() {
        profileImageView.pin.size(self.bounds.height).vCenter().left()
        profileImageView.layer.cornerRadius = self.bounds.height/2
        profileImageView.clipsToBounds = true
        nameLabel.pin.centerLeft(to: profileImageView.anchor.centerRight).marginLeft(10)
    }
}
