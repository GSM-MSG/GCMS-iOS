import UIKit
import SnapKit
import Then
import DPOTPView
import RxCocoa
import RxGesture
import RxSwift
import Reusable
import RxDataSources
import IQKeyboardManagerSwift

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
        $0.spacing = 25
        $0.cornerRadiusTextField = 5
        $0.dismissOnLastEntry = true
        $0.keyboardType = .numberPad
        $0.fontTextField = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 30.0)!
        $0.backGroundColorTextField = UIColor(red: 55/255, green: 55/255, blue: 58/255, alpha: 1)
        $0.textColorTextField = .white
    }
    
    private let backView = UIView().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        $0.layer.cornerRadius = 26
    }
    
    private let completeButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 18)
        $0.layer.cornerRadius = 9
        $0.backgroundColor = GCMSAsset.Colors.gcmsOnBoardingMainColor.color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
    }
    
    // MARK: - UI
    override func configureVC() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    override func addView() {
        view.addSubViews(backView, mailImage)
        backView.addSubViews(sendMessageLabel, textfield, completeButton)
    }
    
    override func setLayout() {
        mailImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(backView.snp.top).offset(-20)
        }
        backView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(bound.height*0.65)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        sendMessageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mailImage.snp.bottom).offset(12)
        }
        textfield.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sendMessageLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.1066)
            $0.height.equalTo(66)
        }
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(51)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - UI
    
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
    }
    
    override func bindView(reactor: CertificationReactor) {
        view.rx.anyGesture(.tap(), .swipe(direction: .down))
            .when(.recognized)
            .map { _ in Reactor.Action.dismiss }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
