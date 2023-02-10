import UIKit
import Service
import SnapKit
import Kingfisher
import Then
import RxSwift
import RxCocoa
import RxGesture

protocol UserProfileViewDelegate: AnyObject {
    func logoutButtonDidTap()
    func profileImageButtonDidTap()
}

final class UserProfileView: UIView {
    // MARK: - Properties
    weak var delegate: UserProfileViewDelegate?
    private let decorator1 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.298, green: 0.326, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 9
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
    }
    private let decorator2 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.298, green: 0.326, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 9
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    private let decorator3 = UIView().then {
        $0.backgroundColor = UIColor(red: 0.452, green: 0.539, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 9
    }
    private let userProfileImageView = UIImageView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 28
        $0.clipsToBounds = true
    }
    private let userNameLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 14)
        $0.textColor = .black
    }
    private let userInfoLabel = UILabel().then {
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
        $0.textColor = .lightGray
    }
    private let logoutButton = UIButton().then {
        $0.setImage(.init(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        $0.tintColor = .black
    }
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        addView()
        setLayout()
        configureUI()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    public func setUser(_ user: UserProfile) {
        if let url = user.profileImageUrl, !url.isEmpty {
            userProfileImageView.kf.setImage(with: URL(string: url) ?? .none,
                                             placeholder: UIImage())
        } else {
            userProfileImageView.image = UIImage(systemName: "person.crop.circle")
        }
        userNameLabel.text = user.name
        userInfoLabel.text = "\(user.grade)학년 \(user.classNum)반 \(user.number)번"
    }
}

// MARK: - UI
private extension UserProfileView {
    func addView() {
        addSubViews(userProfileImageView, userNameLabel, userInfoLabel, logoutButton, decorator1, decorator3, decorator2)
    }
    func setLayout() {
        decorator1.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(7)
            $0.height.equalTo(18)
            $0.width.equalTo(31)
        }
        decorator2.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(11)
            $0.height.equalTo(22)
            $0.width.equalTo(65)
        }
        decorator3.snp.makeConstraints {
            $0.bottom.equalTo(decorator2.snp.top).offset(10)
            $0.trailing.equalTo(decorator2)
            $0.height.equalTo(18)
            $0.width.equalTo(31)
        }
        userProfileImageView.snp.makeConstraints {
            $0.size.equalTo(56)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(16)
            $0.bottom.equalTo(self.snp.centerY)
        }
        userInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel)
            $0.top.equalTo(self.snp.centerY)
        }
        logoutButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
    }
    
    func bindView() {
        logoutButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.delegate?.logoutButtonDidTap()
            }
            .disposed(by: disposeBag)
        
        userProfileImageView.rx.tapGesture()
            .when(.recognized)
            .bind(with: self) { owner, _ in
                owner.delegate?.profileImageButtonDidTap()
            }
            .disposed(by: disposeBag)
    }
}
