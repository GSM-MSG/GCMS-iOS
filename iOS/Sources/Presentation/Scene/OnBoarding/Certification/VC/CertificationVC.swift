import UIKit
import SnapKit
import Then
import DPOTPView

final class CertificationVC: BaseVC<CertificationReactor> {
    // MARK: - Properties
    
    private let mailImage = UIImageView().then {
        $0.image = UIImage(named: "GCMS_Mail.svg")
    }
    
    private let sendMessageLabel = UILabel().then {
        $0.text = "입력하신 이메일로\n 4자리 코드를 보냈어요!"
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 18)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private let textfield = DPOTPView().then {
        $0.isCursorHidden = true
        $0.count = 4
        $0.spacing = 30
        $0.cornerRadiusTextField = 5
        $0.dismissOnLastEntry = true
        $0.fontTextField = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 19.0)!
        $0.backGroundColorTextField = UIColor(red: 55/255, green: 55/255, blue: 58/255, alpha: 1)
        $0.textColorTextField = .white
    }
    
    private let dismissButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .white
    }
    
    // MARK: - UI
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func addView() {
        view.addSubViews(mailImage,sendMessageLabel, textfield, dismissButton)
    }
    
    override func setLayout() {
        mailImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(bound.height*0.2893)
        }
        sendMessageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mailImage.snp.bottom).offset(22)
        }
        textfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sendMessageLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(66)
        }
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(1)
            $0.trailing.equalTo(0)
            $0.width.height.equalTo(50)
        }
    }
    
    // MARK: - UI
    
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
        self.navigationItem.title = "안녕하세요"
    }
    
}
