import UIKit
import SnapKit
import Configure
import Kingfisher
import Service

final class ClubView: UIView {
    // MARK: - Properties
    private let clubBannerView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 13)
        $0.textColor = .white
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
    }
    public private(set) var club: ClubList?

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
    public func setClub(club: ClubList?) {
        guard let club = club else {
            self.isHidden = true
            return
        }
        self.isHidden = false
        self.club = club
        clubBannerView.kf.setImage(with: URL(string: club.bannerImg) ?? .none,
                                   placeholder: UIImage(),
                                   options: [])
        nameLabel.text = club.name
    }
    public func cancelImageDownload() {
        clubBannerView.kf.cancelDownloadTask()
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
            $0.bottom.equalTo(nameLabel.snp.top).offset(-7)
        }
    }
}
