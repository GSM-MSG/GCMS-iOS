import UIKit
import SnapKit
import Then
import Kingfisher

final class ClubView: UIView {
    // MARK: - Properties
    private let clubBannerView = UIImageView()
    private let nameLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    // MARK: - UI
    init() {
        super.init(frame: .zero)
        addView()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    public func setImage(url: String) {
        clubBannerView.kf.setImage(with: URL(string: url) ?? .none,
                                   placeholder: UIImage(),
                                   options: [])
        clubBannerView.layer.cornerRadius = 10
        clubBannerView.clipsToBounds = true
    }
    public func setName(name: String) {
        self.nameLabel.text = name
    }
}

// MARK: - UI
private extension ClubView {
    func addView() {
        addSubViews(clubBannerView, nameLabel)
    }
    func setLayout() {
        nameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(33)
        }
        clubBannerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(nameLabel.snp.top).inset(5)
        }
    }
}
