import UIKit
import GoogleSignIn
import Then
import SnapKit
import RxCocoa
import AuthenticationServices

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
    private let googleSigninButton = UIButton().then {
        $0.setTitle("Sign in with Google", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setImage(GCMSAsset.Images.gcmsGoogleLogo.image.downSample(size: .init(width: 6, height: 6)), for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 18)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
        if #available(iOS 15.0, *){
            $0.configuration = .plain()
            $0.configuration?.imagePadding = 10
        } else {
            $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        }
    }
    private let appleSigninButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
    
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
        appleSigninButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalToSuperview().offset(-bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        googleSigninButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalTo(appleSigninButton.snp.top).offset(-30)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
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
