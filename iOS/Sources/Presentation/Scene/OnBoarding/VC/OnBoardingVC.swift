import UIKit
import GoogleSignIn
import Then
import SnapKit
import RxCocoa

final class OnBoardingVC: BaseVC<OnBoardingReactor> {
    // MARK: - Properties
    private let headerLabel = UILabel().then {
        $0.text = "GSM동아리\n신청앱"
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 34)
    }
    private let nameLabel = UILabel().then {
        $0.text = "GCMS"
        $0.textColor = .white
        $0.font = UIFont(font: GCMSFontFamily.SassyFrass.regular, size: 24)
    }
    private let logoImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsWhaleLogo.image.withRenderingMode(.alwaysOriginal)
    }
    private let googleSigninButton = GoogleSigninButton(title: "Sign in with Google")
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(headerLabel, nameLabel, logoImageView, googleSigninButton)
    }
    override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom)
            $0.leading.equalTo(headerLabel)
        }
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(bound.height*0.2)
            $0.width.equalTo(234)
            $0.height.equalTo(266)
        }
        googleSigninButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview().inset(bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: OnBoardingReactor) {
        googleSigninButton.rx.tap
            .withUnretained(self)
            .map { Reactor.Action.googleSigninButtonDidTap($0.0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
