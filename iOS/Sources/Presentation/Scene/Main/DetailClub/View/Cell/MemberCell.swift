import UIKit
import Service
import PinLayout
import Kingfisher

final class MemberCell: BaseCollectionViewCell<User> {
    // MARK: - Properties
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
        $0.textAlignment = .center
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(profileImageView, nameLabel)
    }
    override func setLayoutSubviews() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(bounds.width)
            $0.top.centerY.equalToSuperview()
        }
        profileImageView.layer.cornerRadius = self.bounds.width/2
        profileImageView.clipsToBounds = true
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    
    override func bind(_ model: User) {
        profileImageView.kf.setImage(with: URL(string: model.picture) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        nameLabel.text = model.name
        
    }
}
