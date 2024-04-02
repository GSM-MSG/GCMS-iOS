import SnapKit
import UIKit
import Configure

protocol ClubMemberListCellDelegate: AnyObject {
    func selectedMemberRowdidTap(isSelected: Bool)
}

final class ClubMemberListCell: BaseTableViewCell<Void> {
    static let identifier = "ClubMemberListCell"
    private var isS: Bool
    private let profileImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsProfile.image.withRenderingMode(.alwaysOriginal)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.text = "2학년2반13번"
        $0.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 13)
        $0.textColor = .white
    }
    private let studentNumberLabel = UILabel().then {
        $0.text = "이승화"
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 11)
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
    }
    private var attendRadioButton = GCMSRadioButton().then {
        $0.isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addView() {
        contentView.addSubViews(profileImageView, nameLabel, studentNumberLabel, attendRadioButton)
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        studentNumberLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        attendRadioButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(27)
        }
    }
    override func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
