import UIKit
import Service
import Kingfisher

final class ClubMemberCell: BaseCollectionViewCell<User> {
    // MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 30.5
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
        $0.textAlignment = .center
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        profileImageView.kf.cancelDownloadTask()
    }

    // MARK: - UI
    override func addView() {
        addSubViews(profileImageView, nameLabel)
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(61)
            $0.top.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    override func bind(_ model: User) {
        if let url = model.profileImg {
            profileImageView.kf.setImage(with: URL(string: url) ?? .none,
                                         placeholder: UIImage(),
                                         options: [])
        } else {
            profileImageView.image = .init(systemName: "person.crop.circle")
        }
        nameLabel.text = model.name

    }
}
