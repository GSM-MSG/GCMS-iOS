import UIKit
import Then
import SnapKit

final class SignUpVC : BaseVC<SignUpReactor> {
    // MARK: - Properties
    
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
        $0.setTitle("인증하기", for: .normal)
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
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(emailTextfield, passwordTextfield, retryPasswordTextfield, certificationButton, completeButton)
    }
    
    override func setLayout() {
        emailTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(bound.height*0.1924)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        passwordTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalTo(emailTextfield.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        retryPasswordTextfield.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-10)
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(51)
        }
        certificationButton.snp.makeConstraints {
            $0.trailing.equalTo(emailTextfield.snp.trailing).offset(-9)
            $0.top.equalTo(emailTextfield.snp.top).offset(10)
            $0.height.equalTo(31)
            $0.width.equalTo(61)
        }
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalToSuperview().offset(-bound.height*0.1)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
        self.navigationItem.configBack()
    }
    
}
