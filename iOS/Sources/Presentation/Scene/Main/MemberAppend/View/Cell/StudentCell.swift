import UIKit
import Service

final class StudentCell: BaseTableViewCell<User> {
    // MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 22
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .init(font: GCMSFontFamily.Inter.semiBold, size: 13)
    }
    private let classLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray3.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 11)
    }
    private let labelStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    // MARK: - UI
    override func addView() {
        labelStack.addArrangeSubviews(nameLabel, classLabel)
        contentView.addSubViews(profileImageView, labelStack)
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        labelStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
    }
    override func configureCell() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    override func bind(_ model: User) {
        profileImageView.kf.setImage(with: URL(string: model.picture) ?? .none,
                                     placeholder: UIImage(),
                                     options: [])
        nameLabel.text = model.name
        classLabel.text = "\(model.grade)학년 \(model.class)반 \(model.number)번"
    }
}
