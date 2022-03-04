import UIKit
import Service
import SnapKit

final class AlarmCell: BaseTableViewCell<Alarm> {
    // MARK: - Properties
    private let view = UIView()
    private let nameLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray5.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 13)
    }
    private let contentLabel = UILabel().then {
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.regular, size: 11)
        $0.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(view)
        view.addSubViews(nameLabel, contentLabel)
    }
    override func setLayout() {
        view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(5)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(15)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    override func configureCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        view.backgroundColor = GCMSAsset.Colors.gcmsGray1.color
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
    }
    override func bind(_ model: Alarm) {
        nameLabel.text = model.name
        contentLabel.text = model.content
    }
}
