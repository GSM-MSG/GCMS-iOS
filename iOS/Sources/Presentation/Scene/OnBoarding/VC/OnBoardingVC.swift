import UIKit
import GoogleSignIn
import Then
import SnapKit
import RxCocoa
import AuthenticationServices
import Service
import RxSwift

final class OnBoardingVC: BaseVC<OnBoardingReactor> {
    // MARK: - Properties
    private let headerLabel = UILabel().then {
        $0.text = "GSM동아리\n관리의 모든 것"
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 34)
    }
    private let logoImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsgLogo.image.withRenderingMode(.alwaysOriginal)
    }
    private let signUpLabel = UILabel().then {
        $0.text = "Sign Up"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
    }
    private let nowLabel = UILabel().then {
        $0.text = "it’s GCMS sign up now"
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
    }
    private let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 18)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
    }
    private let signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 18)
        $0.setTitleColor(.init(red: 50/255, green: 56/255, blue: 187/255, alpha: 1), for: .normal)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsGray1.color
    }
    // MARK: - UI
    override func addView() {
        view.addSubViews(headerLabel, logoImageView, loginButton, signUpButton, signUpLabel, nowLabel)
    }
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(bound.height*0.23)
            $0.width.equalTo(145)
            $0.height.equalTo(145)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalToSuperview().offset(-bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalTo(signUpButton.snp.top).offset(-12)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        nowLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(loginButton.snp.top).offset(-42)
        }
        signUpLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nowLabel.snp.top).offset(-4)
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
        
    }
    override func bindState(reactor: OnBoardingReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}
