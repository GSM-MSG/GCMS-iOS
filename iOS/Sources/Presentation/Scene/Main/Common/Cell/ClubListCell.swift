import UIKit
import Service

final class ClubListCell: BaseCollectionViewCell<ClubList> {
    // MARK: - Properties
    private let clubView = ClubView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
    }
    
    // MARK: - UI
    override func addView() {
        addSubViews(clubView)
    }
    override func setLayout() {
        clubView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    override func bind(_ model: ClubList) {
        clubView.setClub(club: model)
    }
}
