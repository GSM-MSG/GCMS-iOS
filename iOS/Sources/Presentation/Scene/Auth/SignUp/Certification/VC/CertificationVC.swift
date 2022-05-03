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
    private let backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    private let mailImage = UIImageView(image: UIImage(named: "GCMS_Mail.svg"))
    
    private let sendMessageLabel = UILabel().then {
        $0.text = "입력하신 이메일로\n 4자리 코드를 보냈어요!"
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 18)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private let codeOTPTextField = DPOTPView().then {
        $0.isCursorHidden = true
        $0.count = 4
        $0.spacing = 25
        $0.cornerRadiusTextField = 5
        $0.dismissOnLastEntry = true
        $0.keyboardType = .numberPad
        $0.fontTextField = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 30.0)!
        $0.backGroundColorTextField = UIColor(red: 55/255, green: 55/255, blue: 58/255, alpha: 1)
        $0.textColorTextField = .white
        $0.borderWidthTextField = 0
        $0.selectedBorderColorTextField = GCMSAsset.Colors.gcmsMainColor.color
        $0.selectedBorderWidthTextField = 1
    }
    
    private let rootView = UIView().then {
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
        codeOTPTextField.dpOTPViewDelegate = nil
    }
    
    // MARK: - UI
    override func setup() {
        codeOTPTextField.dpOTPViewDelegate = self
    }
    
    override func addView() {
        view.addSubViews(backgroundView, rootView, mailImage)
        rootView.addSubViews(sendMessageLabel, codeOTPTextField, completeButton)
    }
    
    override func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        mailImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(rootView.snp.top).offset(-20)
        }
        rootView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(bound.height*0.65)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        sendMessageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mailImage.snp.bottom).offset(12)
        }
        codeOTPTextField.snp.makeConstraints {
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
    
    override func configureVC() {
        view.backgroundColor = .clear
    }
    
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
    }
    
    // MARK: - Reactor
    
    override func bindState(reactor: CertificationReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }

    override func bindView(reactor: CertificationReactor) {
        backgroundView.rx.anyGesture(.tap(), .swipe(direction: .down))
            .when(.recognized)
            .map { _ in Reactor.Action.dismiss }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .do(onNext: { [weak self] _ in
                self?.codeOTPTextField.text?.removeAll()
            })
            .map { Reactor.Action.completeButotnDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

extension CertificationVC : DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        reactor?.action.onNext(.updateCode(text))
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        reactor?.action.onNext(.updateCode(text))
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {}
    
    func dpOTPViewBecomeFirstResponder() {}
    
    func dpOTPViewResignFirstResponder() {}
}
