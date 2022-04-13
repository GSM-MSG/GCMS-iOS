import UIKit
import Then
import SnapKit
import ReactorKit
import RxFlow
import Service
import ViewAnimator
import IQKeyboardManagerSwift

final class SignUpVC : BaseVC<SignUpReactor> {
    // MARK: - Properties
    
    private let logoImageView = UIImageView().then {
        $0.image = GCMSAsset.Images.gcmsgLogo.image.withRenderingMode(.alwaysOriginal)
    }
    private let signUpLabel = UILabel().then {
        $0.text = "Sign Up"
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
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
        $0.attributedPlaceholder = NSAttributedString(string: "8~20자의 비밀번호를 입력해주세요", attributes: [
            .foregroundColor: GCMSAsset.Colors.gcmsGray4.color,
            .font: UIFont(font: GCMSFontFamily.Inter.medium, size: 13)!
        ])
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.leftSpace(13)
        $0.isSecureTextEntry = true
    }
    
    private let retryPasswordTextfield = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호를 다시 입력해주세요", attributes: [
            .foregroundColor: GCMSAsset.Colors.gcmsGray4.color,
            .font: UIFont(font: GCMSFontFamily.Inter.medium, size: 13)!
        ])
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.leftSpace(13)
        $0.isSecureTextEntry = true
    }
    
    private let certificationButton = UIButton().then {
        $0.setTitle("인증", for: .normal)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 12)
    }
    
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 18)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
    }
    
    private let emailLabel = UILabel().then {
        $0.text = "@gsm.hs.kr"
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 7
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.textAlignment = .center
    }
    
    private let invalidLabel = UILabel().then {
        $0.text = "유효하지 않은 이메일입니다."
        $0.textColor = GCMSAsset.Colors.gcmsThemeColor.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.regular, size: 11)
        $0.isHidden = true
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
    
    // MARK: - UI
    
    override func setup() {
        passwordTextfield.delegate = self
        retryPasswordTextfield.delegate = self
    }

    override func addView() {
        view.addSubViews(primaryWaveView, secondaryWaveView, thirdWaveView, emailTextfield, passwordTextfield, retryPasswordTextfield, certificationButton, completeButton, logoImageView, signUpLabel, invalidLabel)
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
            primaryWaveView, secondaryWaveView, thirdWaveView, logoImageView, signUpLabel
        ], animations: [
            AnimationType.from(direction: .top, offset: 300),
        ], duration: 1.6)
        UIView.animate(views: [
            retryPasswordTextfield, passwordTextfield, emailTextfield, certificationButton
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 3)
        ], delay: 1.4, duration: 1.2)
        UIView.animate(views: [
            completeButton
        ], animations: [
            AnimationType.from(direction: .bottom, offset: 30)
        ], delay: 1.4, duration: 1.2)
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
        signUpLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(9)
        }
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        invalidLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(completeButton.snp.top).offset(-33)
        }
        retryPasswordTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(invalidLabel.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        passwordTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(retryPasswordTextfield.snp.top).offset(-14)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        emailTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(passwordTextfield.snp.top).offset(-14)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        certificationButton.snp.makeConstraints {
            $0.trailing.equalTo(emailTextfield.snp.trailing).offset(-9)
            $0.top.equalTo(emailTextfield.snp.top).offset(10)
            $0.height.equalTo(31)
            $0.width.equalTo(61)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    
    override func bindState(reactor: SignUpReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isEmailNotFound)
            .bind(with: self) { owner, item in
                owner.emailTextfield.layer.borderColor = item ? GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.passwordTextfield.layer.borderColor = item ? GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.retryPasswordTextfield.layer.borderColor = item ? GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.invalidLabel.text = "이메일을 다시 입력해주세요"
                owner.invalidLabel.isHidden = !item
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isInvalidPassword)
            .bind(with: self) { owner, item in
                owner.emailTextfield.layer.borderColor = item ? GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.passwordTextfield.layer.borderColor = item ? GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.retryPasswordTextfield.layer.borderColor = item ? GCMSAsset.Colors.gcmsThemeColor.color.cgColor : GCMSAsset.Colors.gcmsGray3.color.cgColor
                owner.invalidLabel.text = "비밀번호를 다시 입력해주세요"
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
    
    override func bindView(reactor: SignUpReactor) {
        certificationButton.rx.tap
            .do(onNext: {
                IQKeyboardManager.shared.resignFirstResponder()
            })
            .map { Reactor.Action.certificationButtonDidTap }
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
        
        completeButton.rx.tap
            .map { Reactor.Action.completeButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}

extension SignUpVC : UITextFieldDelegate {
    
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
