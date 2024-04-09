import SnapKit
import UIKit
import Configure
import RxSwift

final class ClubMemberListCell: BaseTableViewCell<Void> {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
    }
    
    private let profileImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsProfile.image.withRenderingMode(.alwaysOriginal)
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.text = "이승화"
        $0.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 13)
        $0.textColor = .white
    }
    private let studentNumberLabel = UILabel().then {
        $0.text = "2학년2반13번"
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 11)
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
    }
    private var attendCheckBox = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addView() {
        contentView.addSubViews(profileImageView, nameLabel, studentNumberLabel, attendCheckBox)
    }
    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        studentNumberLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        attendCheckBox.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(27)
        }
    }
    override func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            attendCheckBox.image = GCMSAsset.Images.checkBoxFill.image
        } else {
            attendCheckBox.image = GCMSAsset.Images.checkBox.image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
