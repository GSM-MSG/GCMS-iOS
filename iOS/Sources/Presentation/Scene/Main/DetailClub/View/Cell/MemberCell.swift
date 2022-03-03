import UIKit
import Service
import PinLayout
import Kingfisher

final class MemberCell: BaseCollectionViewCell<User> {
    // MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsGray3.color
    }
    private let nameLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
        $0.textAlignment = .center
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(profileImageView, nameLabel)
    }
    override func setLayoutSubviews() {
        profileImageView.pin.size(self.bounds.width).top().hCenter()
        profileImageView.layer.cornerRadius = self.bounds.width/2
        profileImageView.clipsToBounds = true
        nameLabel.pin.topCenter(to: profileImageView.anchor.bottomCenter).marginTop(5).sizeToFit()
    }
    
    override func bind(_ model: User) {
        profileImageView.kf.setImage(with: URL(string: model.profileImage) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        nameLabel.text = model.name
        
    }
}
