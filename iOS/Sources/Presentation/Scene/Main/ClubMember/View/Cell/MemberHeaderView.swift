import UIKit
import Then
import SnapKit

final class MemberHeaderView: BaseTableViewHeaderFooterView<String> {
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = .init(font: GCMSFontFamily.Inter.medium, size: 18)
    }
    private let isOpenedImageView = UIImageView(image: .init(systemName: "chevron.left")?.tintColor(.white))
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(titleLabel, isOpenedImageView)
    }
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        isOpenedImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.size.equalTo(20)
        }
    }
    override func configureCell() {
        self.backgroundColor = .clear
    }
    
    override func bind(_ model: String) {
        titleLabel.text = model
    }
    public func setIsOpened(isOpen: Bool) {
        isOpenedImageView.rotate(isOpen ? 0.0 : .pi)
    }
}
