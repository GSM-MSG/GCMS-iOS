import UIKit
import Service
import SnapKit
import Kingfisher
import RxSwift

protocol StatusMemberCellDelegate: AnyObject {
    func kicktButtonDidTap(user: Member)
    func delegationButtonDidTap(user: Member)
}

final class StatusMemberCell: BaseTableViewCell<Member> {
    // MARK: - Properties
    weak var delegate: StatusMemberCellDelegate?

    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 13)
        $0.textColor = .white
    }
    private let infoLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 11)
        $0.textColor = GCMSAsset.Colors.gcmsGray3.color
    }
    private let delegationButton = UIButton().then {
        $0.setTitle("위임", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 11)
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 4
    }
    private let kickButton = UIButton().then {
        $0.setTitle("강퇴", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 11)
        $0.backgroundColor = GCMSAsset.Colors.gcmsThemeColor.color
        $0.layer.cornerRadius = 4
    }
    public var isHead: Bool = false {
        didSet {
            [delegationButton, kickButton].forEach {
                $0.isHidden = !isHead
            }
        }
    }

    // MARK: - UI
    override func addView() {
        contentView.addSubViews(profileImageView, nameLabel, infoLabel, delegationButton, kickButton)
    }

    override func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.centerY)
            $0.leading.equalTo(nameLabel)
        }
        kickButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(30)
            $0.width.equalTo(48)
        }
        delegationButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(kickButton.snp.leading).offset(-10)
            $0.height.equalTo(30)
            $0.width.equalTo(48)
        }

    }
    override func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        model = nil
        disposeBag = DisposeBag()
        profileImageView.kf.cancelDownloadTask()
    }

    override func bind(_ model: Member) {
        if let url = model.profileImg, !url.isEmpty {
            profileImageView.kf.setImage(with: URL(string: url) ?? .none,
                                         placeholder: UIImage(),
                                         options: [])
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle")
        }
        nameLabel.text = model.name
        infoLabel.text = "\(model.grade)학년\(model.classNum)반\(model.number)번"
        [delegationButton, kickButton].forEach {
            $0.isHidden = (!isHead || model.scope == .head)
        }

        delegationButton.rx.tap
            .compactMap { [weak self] in self?.model }
            .bind(with: self) { owner, model in
                owner.delegate?.delegationButtonDidTap(user: model)
            }
            .disposed(by: disposeBag)

        kickButton.rx.tap
            .compactMap { [weak self] in self?.model }
            .bind(with: self) { owner, model in
                owner.delegate?.kicktButtonDidTap(user: model)
            }
            .disposed(by: disposeBag)
    }
}
