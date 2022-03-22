import UIKit
import Then
import SnapKit
import RxCocoa
import AuthenticationServices
import Service
import RxSwift

final class LoginVC : BaseVC<LoginReactor> {
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsgLogo.image.withRenderingMode(.alwaysOriginal)
    }
    private let signUpLabel = UILabel().then {
        $0.text = "Sign Up"
        $0.font = .systemFont(ofSize: 24, weight: .semibold)
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 18)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
    }
    
    private let findPasswordButton = UIButton().then {
        let attributedString = NSMutableAttributedString(string: "계정을 잊으셨나요? ID찾기 또는 비밀번호 찾기")
        attributedString.setColorForText(textToFind: "비밀번호 찾기", withColor: UIColor(red: 82/255, green: 196/255, blue: 255/255, alpha: 1))
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.regular, size: 11)
    }
    
    private let emailTextfield = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "학교 이메일을 입력해주세요", attributes: [
            .foregroundColor: GCMSAsset.Colors.gcmsGray4.color,
            .font: UIFont(font: GCMSFontFamily.Inter.medium, size: 13)!
        ])
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.leftSpace(13)
    }
    
    private let passwordTextfield = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력해주세요", attributes: [
            .foregroundColor: GCMSAsset.Colors.gcmsGray4.color,
            .font: UIFont(font: GCMSFontFamily.Inter.medium, size: 13)!
        ])
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.leftSpace(13)
        $0.isSecureTextEntry = true
    }
    
    private let emailText = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.textAlignment = .center
    }
    
    private let passwordVisibleButton = UIButton().then {
        $0.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        $0.tintColor = GCMSAsset.Colors.gcmsGray4.color
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(logoImageView, signUpLabel, loginButton,findPasswordButton, emailTextfield, emailText, passwordTextfield, passwordVisibleButton)
    }
    
    override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(bound.height*0.28)
            $0.width.equalTo(111)
            $0.height.equalTo(111)
        }
        signUpLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(9)
        }
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalToSuperview().offset(-bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        passwordTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(findPasswordButton.snp.top).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        findPasswordButton.snp.makeConstraints {
            $0.bottom.equalTo(loginButton.snp.top).offset(-49)
            $0.leading.equalTo(passwordTextfield.snp.leading).offset(3)
        }
        passwordVisibleButton.snp.makeConstraints {
            $0.trailing.equalTo(passwordTextfield.snp.trailing).offset(-10)
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.bottom.equalTo(passwordTextfield.snp.bottom).offset(-10)
        }
        emailTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(passwordTextfield.snp.top).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        emailText.snp.makeConstraints {
            $0.trailing.equalTo(emailTextfield.snp.trailing)
            $0.bottom.equalTo(emailTextfield.snp.bottom)
            $0.height.equalTo(emailTextfield.snp.height)
            $0.width.equalTo(emailText.snp.height).multipliedBy(2)
        }
    }
    
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    
    override func bindState(reactor: LoginReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.passwordVisible)
            .subscribe(with: self){ owner, item in
                owner.passwordVisibleButton.setImage(UIImage(systemName: item ? "eye.slash.fill" : "eye.fill"), for: .normal)
                owner.passwordTextfield.isSecureTextEntry = item
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoginFailure)
            .subscribe(with: self){ owner, item in
                owner.emailTextfield.layer.borderColor = item ? UIColor(red: 255/255, green: 129/255, blue: 129/255, alpha: 1).cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.emailText.layer.borderColor = item ? UIColor(red: 255/255, green: 129/255, blue: 129/255, alpha: 1).cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.passwordTextfield.layer.borderColor = item ? UIColor(red: 255/255, green: 129/255, blue: 129/255, alpha: 1).cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
    
    override func bindView(reactor: LoginReactor) {
        loginButton.rx.tap.observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.loginButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordVisibleButton.rx.tap.observe(on: MainScheduler.asyncInstance)
            .map { Reactor.Action.passwordVisibleButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        emailTextfield.rx.text.orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateEmail)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        passwordTextfield.rx.text.orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updatePassword)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
