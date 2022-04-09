import UIKit
import Service
import SnapKit
import Kingfisher

final class ApplicantCell: BaseTableViewCell<User> {
    // MARK: - Properties
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let infoLabel = UILabel()
    private let acceptButton = UIButton()
    private let rejectButton = UIButton()
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(profileImageView, nameLabel, infoLabel, acceptButton, rejectButton)
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
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
        acceptButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        rejectButton.snp.makeConstraints {
            $0.trailing.equalTo(acceptButton.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
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
