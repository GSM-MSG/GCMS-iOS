import UIKit
import Service
import PinLayout

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
    override func setLayoutSubviews() {
        clubView.pin.all()
    }
    override func bind(_ model: ClubList) {
        clubView.setImage(url: model.bannerUrl)
        clubView.setName(name: model.title)
    }
}
