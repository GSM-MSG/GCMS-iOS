import UIKit
import Service
import SnapKit
import Kingfisher

final class StatusMemberCell: BaseTableViewCell<User> {
    // MARK: - Properties
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    private let delegationButton = UIButton()
    private let kickButton = UIButton()
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(profileImageView, nameLabel, infoLabel, delegationButton, kickButton)
    }
    
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(nameLabel)
        }
        kickButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }
        delegationButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(kickButton.snp.leading).offset(-10)
        }
        
    }
    
    override func bind(_ model: User) {
        if let url = model.profileImageUrl, !url.isEmpty {
            profileImageView.kf.setImage(with: URL(string: url) ?? .none,
                                         placeholder: UIImage(),
                                         options: [])
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle")
        }
        nameLabel.text = model.name
        infoLabel.text = "\(model.grade)학년\(model.class)반\(model.number)번"
    }
}
