import UIKit
import SnapKit
import Then

final class AfterSchoolTableViewCell: BaseTableViewCell<Void> {
    // MARK: - Propreties
    private let titleLabel = SemiBoldTextLabel(title: "컴퓨터 활용 능력", weight: .semibold)

    // MARK: - UI
    override func addView() {
        contentView.addSubViews(titleLabel)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.height.equalTo(40)
            $0.width.equalTo(80)
        }
    }
    
    override func configureCell() {
        backgroundColor = .white
    }
}
