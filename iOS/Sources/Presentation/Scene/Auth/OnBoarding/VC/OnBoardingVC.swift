import UIKit
import Then
import SnapKit
import AuthenticationServices
import RxSwift
import ViewAnimator

final class OnBoardingVC: BaseVC<OnBoardingReactor> {
    // MARK: - Properties
    private let headerLabel = UILabel().then {
        $0.text = "GSM동아리\n관리의 모든 것"
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 34)
        $0.textAlignment = .center
    }
    private let logoImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsgLogo.image.withRenderingMode(.alwaysOriginal)
    }
    private let signUpLabel = UILabel().then {
        $0.text = "Sign Up"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
    }
    private let contentsLabel = UILabel().then {
        $0.text = "it’s GCMS sign up now"
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
    }
    private let googleSigninButton = UIButton().then {
        $0.setTitle("Google로 계속하기", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.setImage(GCMSAsset.Images.gcmsGoogleLogo.image.downSample(size: .init(width: 5.5, height: 5.5)), for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
        $0.layer.cornerRadius = 9
        if #available(iOS 15.0, *) {
            $0.configuration = .plain()
            $0.configuration?.imagePadding = 5
            $0.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .systemFont(ofSize: 20)
                return outgoing
            }
        } else {
            $0.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 5)
        }
    }
    private let appleSigninButton = ASAuthorizationAppleIDButton(type: .continue, style: .white)
    // MARK: - UI
    override func addView() {
        view.addSubViews(headerLabel, logoImageView, googleSigninButton, appleSigninButton, signUpLabel, contentsLabel)
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(bound.height*0.21)
            $0.width.equalTo(144)
            $0.height.equalTo(144)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
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
            $0.bottom.equalTo(appleSigninButton.snp.top).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        contentsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(googleSigninButton.snp.top).offset(-42)
        }
        signUpLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(contentsLabel.snp.top).offset(-4)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
        self.navigationItem.configBack()
        UIView.animate(views: [
            logoImageView, headerLabel
        ], animations: [
            AnimationType.from(direction: .top, offset: 100)
        ], initialAlpha: 0, finalAlpha: 1, delay: 0.3, duration: 1.25)
        UIView.animate(views: [
            signUpLabel, contentsLabel
        ], animations: [
            
        ], initialAlpha: 0, finalAlpha: 1, delay: 1.05, duration: 0.75)
        UIView.animate(views: [
            googleSigninButton, appleSigninButton
        ], animations: [
            AnimationType.from(direction: .left, offset: 200)
        ], delay: 1.8, duration: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseInOut)
    }
    
    // MARK: - Reactor
    override func bindState(reactor: OnBoardingReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
    
    override func bindView(reactor: OnBoardingReactor) {
        googleSigninButton.rx.tap
            .withUnretained(self)
            .map { Reactor.Action.googleSigninButtonDidTap($0.0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        appleSigninButton.rx.controlEvent(.touchUpInside)
            .bind(with: self) { owner, _ in
                owner.appleSigninMessage()
            }
            .disposed(by: disposeBag)
    }
}

private extension OnBoardingVC {
    func appleSigninMessage() {
        self.reactor?.steps.accept(GCMSStep.alert(title: nil, message: "Apple로 로그인 시 게스트 로그인과 동일시 됩니다", style: .alert, actions: [
            .init(title: "확인", style: .default, handler: { [weak self] _ in
                self?.appleSignin()
            }),
            .init(title: "취소", style: .cancel)
        ]))
    }
    func appleSignin() {
        let provider = ASAuthorizationAppleIDProvider()
        let req = provider.createRequest()
        req.requestedScopes = []
        
        let authController = ASAuthorizationController(authorizationRequests: [req])
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performRequests()
    }
}

extension OnBoardingVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window ?? .init()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        self.reactor?.action.onNext(.appleSigninCompleted)
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.reactor?.action.onNext(.appleSigninFailed)
    }
}
