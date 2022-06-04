import UIKit
import Service
import SnapKit
import Kingfisher
import RxSwift

protocol ApplicantCellDelegate: AnyObject {
    func acceptButtonDidTap(user: User)
    func rejectButtonDidTap(user: User)
}

final class ApplicantCell: BaseTableViewCell<User> {
    // MARK: - Properties
    weak var delegate: ApplicantCellDelegate?
    
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
    private let acceptButton = UIButton().then {
        $0.setTitle("수락", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 11)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.layer.cornerRadius = 4
    }
    private let rejectButton = UIButton().then {
        $0.setTitle("거절", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 11)
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 4
    }
    public var isHead: Bool = false {
        didSet {
            [acceptButton, rejectButton].forEach {
                $0.isHidden = !isHead
            }
        }
    }
    
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(profileImageView, nameLabel, infoLabel, acceptButton, rejectButton)
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
        acceptButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(48)
        }
        rejectButton.snp.makeConstraints {
            $0.trailing.equalTo(acceptButton.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
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
    }
    
    override func bind(_ model: User) {
        if let url = model.profileImageUrl, !url.isEmpty {
            profileImageView.kf.setImage(with: URL(string: url) ?? .none,
                                         placeholder: UIImage(),
                                         options: [])
        } else {
            profileImageView.image = UIImage(systemName: "person.crop.circle")
        }
        nameLabel.text = model.name
        infoLabel.text = "\(model.grade)학년\(model.class)반\(model.number)번"
        
        acceptButton.rx.tap
            .compactMap { [weak self] in self?.model }
            .bind(with: self) { owner, model in
                owner.delegate?.acceptButtonDidTap(user: model)
            }
            .disposed(by: disposeBag)
        
        rejectButton.rx.tap
            .compactMap { [weak self] in self?.model }
            .bind(with: self) { owner, model in
                owner.delegate?.rejectButtonDidTap(user: model)
            }
            .disposed(by: disposeBag)
    }
}
