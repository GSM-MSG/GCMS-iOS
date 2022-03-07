import UIKit
import Service

final class AddedUserCell: BaseCollectionViewCell<User> {
    // MARK: - Properties
    private let nameLabel = UILabel().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.backgroundColor = GCMSAsset.Colors.gcmsGray1.color
        $0.textColor = GCMSAsset.Colors.gcmsGray6.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 12)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(nameLabel)
    }
    override func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    override func configureCell() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    override func bind(_ model: User) {
        nameLabel.text = model.name
    }
    
    static func fittingSize(availableHeight: CGFloat, user: User) -> CGSize {
        let cell = AddedUserCell()
        cell.model = user
        let target = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        let width = cell.contentView.systemLayoutSizeFitting(target, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required).width + 10
        return .init(width: width, height: availableHeight)
    }
}
