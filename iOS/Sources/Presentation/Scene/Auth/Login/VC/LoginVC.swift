import UIKit
import Then
import SnapKit
import RxCocoa
import IQKeyboardManagerSwift
import Service
import RxSwift
import ViewAnimator
import ParkedTextField

final class LoginVC : BaseVC<LoginReactor> {
    // MARK: - Properties
    private let logoImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsgLogo.image.withRenderingMode(.alwaysOriginal)
    }
    private let loginLabel = UILabel().then {
        $0.text = "Login"
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
    }
    
    private let loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 18)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
    }
    
    private let findPasswordButton = UIButton().then {
        let attributedString = NSMutableAttributedString(string: "계정을 잊으셨나요? ID찾기 또는 비밀번호 찾기")
        attributedString.setColorForText(textToFind: "비밀번호 찾기",
                                         withColor: UIColor(red: 0.3215,
                                                            green: 0.7686,
                                                            blue: 1,
                                                            alpha: 1))
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.regular, size: 11)
    }
    private let invalidLabel = UILabel().then {
        $0.text = "입력하신 비밀번호 또는 이메일이 틀리셨습니다"
        $0.textColor = GCMSAsset.Colors.gcmsThemeColor.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.regular, size: 11)
        $0.isHidden = true
    }
    private let emailTextfield = ParkedTextField().then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
        $0.leftSpace(13)
        $0.parkedTextFont = UIFont(font: GCMSFontFamily.Inter.medium, size: 15)
        $0.parkedTextColor = GCMSAsset.Colors.gcmsGray2.color
        $0.placeholderText = "학교 이메일을 입력해주세요"
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
    
    private let passwordVisibleButton = UIButton().then {
        $0.tintColor = GCMSAsset.Colors.gcmsGray4.color
    }
    
    private let primaryWaveView = WaveView().then {
        $0.preferredColor = UIColor(red: 0.415, green: 0.439, blue: 1, alpha: 0.9)
    }
    private let secondaryWaveView = WaveView().then {
        $0.preferredColor = UIColor(red: 0.568, green: 0.584, blue: 1, alpha: 0.9)
    }
    private let thirdWaveView = WaveView().then {
        $0.preferredColor = UIColor(red: 0.414, green: 0.438, blue: 0.9, alpha: 0.8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        primaryWaveView.animationStart(direction: .left, speed: 0.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
            self?.secondaryWaveView.animationStart(direction: .right, speed: 0.5)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.thirdWaveView.animationStart(direction: .left, speed: 0.5)
        }
        UIView.animate(views: [
            primaryWaveView, secondaryWaveView, thirdWaveView, logoImageView, loginLabel
        ], animations: [
            AnimationType.from(direction: .top, offset: 300),
        ], duration: 1.6)
        UIView.animate(views: [
            emailTextfield, passwordTextfield, passwordVisibleButton, findPasswordButton
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 3)
        ], delay: 1.4, duration: 1.2)
        UIView.animate(views: [
            loginButton
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 30)
        ], delay: 1.4, duration: 1.2)
    }
    
    // MARK: - UI
    override func setup() {
        [emailTextfield, passwordTextfield].forEach { $0.delegate = self }
    }
    
    override func addView() {
        view.addSubViews(thirdWaveView, secondaryWaveView, primaryWaveView, logoImageView, loginLabel, loginButton,findPasswordButton, invalidLabel, emailTextfield, passwordTextfield, passwordVisibleButton)
    }
    
    override func setLayout() {
        primaryWaveView.snp.makeConstraints {
            $0.centerX.width.top.equalToSuperview()
            $0.height.equalTo(bound.height*0.45)
        }
        secondaryWaveView.snp.makeConstraints {
            $0.centerX.width.top.equalToSuperview()
            $0.height.equalTo(bound.height*0.46)
        }
        thirdWaveView.snp.makeConstraints {
            $0.centerX.width.top.equalToSuperview()
            $0.height.equalTo(bound.height*0.45)
        }
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(bound.height*0.05)
            $0.size.equalTo(109)
        }
        loginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(9)
        }
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
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
        invalidLabel.snp.makeConstraints {
            $0.centerY.equalTo(findPasswordButton)
            $0.centerX.equalToSuperview()
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
                owner.passwordVisibleButton.setImage(UIImage(systemName: item ? "eye.fill" : "eye.slash.fill"), for: .normal)
                owner.passwordTextfield.isSecureTextEntry = !item
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoginFailure)
            .subscribe(with: self){ owner, item in
                owner.emailTextfield.layer.borderColor = item ? GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.passwordTextfield.layer.borderColor = item ?GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.findPasswordButton.isHidden = item
                owner.invalidLabel.isHidden = !item
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
        
        emailTextfield.rx.text.orEmpty
            .map(\.isEmpty)
            .distinctUntilChanged()
            .map { !$0 ? "@gsm.hs.kr" : "" }
            .bind(with: self, onNext: { owner, str in
                owner.emailTextfield.parkedText = str
                owner.emailTextfield.setPlaceholderColor(GCMSAsset.Colors.gcmsGray4.color)
            })
            .disposed(by: disposeBag)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 20 else { return false }
        return true
    }
}
