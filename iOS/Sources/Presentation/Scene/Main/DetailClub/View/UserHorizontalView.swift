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
        if let url = user.profileImg {
            profileImageView.kf.setImage(with: URL(string: url) ?? .none,
                                         placeholder: UIImage(),
                                         options: [])
        } else {
            profileImageView.image = .init(systemName: "person.crop.circle")
        }
        nameLabel.text = user.name
        nameLabel.sizeToFit()
    }
    public func setImage(url: String) {
        profileImageView.kf.setImage(with: URL(string: url) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
    }
    public func setName(name: String) {
        nameLabel.text = name
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
