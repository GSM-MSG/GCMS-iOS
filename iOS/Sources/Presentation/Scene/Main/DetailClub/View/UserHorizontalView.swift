import UIKit
import Service
import Kingfisher

final class UserHorizontalView: UIView {
    // MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 30.5
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
    }
    
    // MARK: - UI
    init() {
        super.init(frame: .zero)
        addView()
        setLayout()
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
    func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(61)
            $0.centerY.leading.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
    }
}
