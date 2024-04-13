import UIKit
import Configure
import SnapKit
import RxSwift
import ViewAnimator
import GAuthSignin
import MSGLayout

final class OnBoardingVC: BaseVC<OnBoardingReactor> {
    // MARK: - Properties
    private let headerLabel = UILabel().then {
        $0.text = "GSM동아리\n관리의 모든 것"
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.numberOfLines = 0
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 34)
        $0.textAlignment = .center
    }
    private let logoImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsgLogo.image.withRenderingMode(.alwaysOriginal)
    }
    private let tosStackView = UIStackView().then {
        $0.spacing = 18
        $0.axis = .horizontal
        $0.alignment = .center
    }
    private let termsOfServiceButton = UIButton().then {
        $0.setTitle("서비스 이용약관", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray4.color, for: .normal)
    }
    private let betweenButtonView = UILabel().then {
        $0.text = "|"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
    }
    private let privacyButton = UIButton().then {
        $0.setTitle("개인정보 처리 방침", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray4.color, for: .normal)
    }
    private let gauthSigninButton = GAuthButton(auth: .signin, color: .white, rounded: .default)

    // MARK: - UI
    override func addView() {
        view.addSubViews(headerLabel, logoImageView, tosStackView, gauthSigninButton)
        tosStackView.addArrangeSubviews(termsOfServiceButton, betweenButtonView, privacyButton)
    }
    override func setLayout() {
        MSGLayout.buildLayout {
            logoImageView.layout
                .centerX(.toSuperview(), .equal(-10))
                .top(.toSuperview(), .equal(bound.height * 0.1439))
                .size(144)

            headerLabel.layout
                .top(.to(logoImageView).bottom, .equal(16))
                .centerX(.toSuperview())

            tosStackView.layout
                .bottom(.to(view.safeAreaLayoutGuide).bottom, .equal(-18))
                .centerX(.toSuperview())

            gauthSigninButton.layout
                .bottom(.to(tosStackView).top, .equal(-36))
                .horizontal(.toSuperview(), .equal(20))
                .height(50)
        }
    }
    override func setup() {
        gauthSigninButton.prepare(
            clientID: Bundle.module.object(forInfoDictionaryKey: "CLIENT_ID") as? String ?? "",
            redirectURI: Bundle.module.object(forInfoDictionaryKey: "REDIREDCT_URI") as? String ?? "",
            presenting: self
        ) { [weak self] code in
            self?.reactor?.action.onNext(.gauthSigninCompleted(code: code))
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
            gauthSigninButton, termsOfServiceButton, privacyButton, betweenButtonView
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
        termsOfServiceButton.rx.tap
            .map { Reactor.Action.termsOfServiceButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        privacyButton.rx.tap
            .map { Reactor.Action.privacyButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
