import UIKit

final class ClubActivityCell: BaseCollectionViewCell<Data> {
    // MARK: - Properties
    private let activityImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(activityImageView)
    }
    override func setLayout() {
        activityImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func configureCell() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    override func bind(_ model: Data) {
        activityImageView.image = UIImage(data: model)
    }
}
