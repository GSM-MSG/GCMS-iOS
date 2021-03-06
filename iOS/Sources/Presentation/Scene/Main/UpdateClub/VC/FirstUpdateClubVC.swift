import UIKit
import IQKeyboardManagerSwift
import SnapKit
import RxKeyboard
import RxSwift

final class FirstUpdateClubVC: BaseVC<UpdateClubReactor> {
    // MARK: - Metric
    enum Metric {
        static let verticalSpacing: CGFloat = 65
        static let horizontalMargin: CGFloat = 20
        static let textFieldHeight: CGFloat = 45
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let progressBar = UpdateSteppedProgressBar(selectedIndex: 0)
    private let clubNameTextField = NewClubTextField(placeholder: "동아리 이름을 입력해주세요.").then {
        $0.addHeaderLabel(title: "동아리 이름")
    }
    private let clubDescriptionHeaderLabel = HeaderLabel(title: "동아리 설명")
    private let clubDescriptionTextView = UITextView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.backgroundColor = .clear
        $0.text = "동아리 설명을 입력해주세요."
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
        $0.textContainerInset = .init(top: 10, left: 5, bottom: 10, right: 5)
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
        $0.toolbarPlaceholder = "동아리 설명을 입력해주세요."
    }
    private let contactTextField = NewClubTextField(placeholder: "연락처를 입력해주세요.(디스코드 등)").then {
        $0.addHeaderLabel(title: "연락처")
    }
    private let notionLinkHeaderLabel = HeaderLabel(title: "노션 링크")
    private let notionLinkTextField = NewClubTextField(placeholder: "링크 URL")
    private let teacherTextField = NewClubTextField(placeholder: "담당 선생님 성함을 입력해주세요.").then {
        $0.addHeaderSelectionLabel(title: "담당 선생님")
    }
    private let nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 56
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView, nextButton)
        scrollView.addSubViews(progressBar, clubNameTextField, clubDescriptionHeaderLabel, clubDescriptionTextView, contactTextField, notionLinkHeaderLabel, notionLinkTextField, teacherTextField)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        progressBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(30)
        }
        clubNameTextField.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(115)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        clubDescriptionTextView.snp.makeConstraints {
            $0.top.equalTo(clubNameTextField.snp.bottom).offset(Metric.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(90)
        }
        clubDescriptionHeaderLabel.snp.makeConstraints {
            $0.leading.equalTo(clubDescriptionTextView)
            $0.bottom.equalTo(clubDescriptionTextView.snp.top).offset(-8)
        }
        contactTextField.snp.makeConstraints {
            $0.top.equalTo(clubDescriptionTextView.snp.bottom).offset(Metric.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        notionLinkTextField.snp.makeConstraints {
            $0.top.equalTo(contactTextField.snp.bottom).offset(Metric.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(Metric.textFieldHeight)
        }
        notionLinkHeaderLabel.snp.makeConstraints {
            $0.leading.equalTo(notionLinkTextField)
            $0.bottom.equalTo(notionLinkTextField.snp.top).offset(-8)
        }
        teacherTextField.snp.makeConstraints {
            $0.top.equalTo(notionLinkTextField.snp.bottom).offset(Metric.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(Metric.textFieldHeight)
            $0.bottom.equalToSuperview().offset(-71)
        }
        nextButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.bottom + 72)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: UpdateClubReactor) {
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(with: self) { owner, height in
                UIView.animate(withDuration: 0) {
                    owner.nextButton.snp.updateConstraints {
                        $0.bottom.equalToSuperview().offset(-height)
                    }
                }
                owner.view.layoutIfNeeded()
            }
            .disposed(by: disposeBag)
        
        clubNameTextField.rx.text.orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateTitle)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        notionLinkTextField.rx.text.orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateNotionLink)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        teacherTextField.rx.text.orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateTeacher)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        contactTextField.rx.text.orEmpty.observe(on: MainScheduler.asyncInstance)
            .map(Reactor.Action.updateContact)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        clubDescriptionTextView.rx.text.orEmpty.observe(on: MainScheduler.asyncInstance)
            .do(onNext: { [weak self] _ in
                let size = CGSize(width: self?.view.frame.width ?? 0, height: .infinity)
                let esti = self?.clubDescriptionTextView.sizeThatFits(size) ?? .init()
                
                self?.clubDescriptionTextView.constraints.forEach { constraint in
                    if esti.height < 90 {}
                    else {
                        if constraint.firstAttribute == .height {
                            constraint.constant = esti.height
                        }
                    }
                }
            }).map(Reactor.Action.updateDescription)
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
        
        clubDescriptionTextView.rx.didBeginEditing
            .asObservable()
            .bind(with: self) { owner, _ in
                if owner.clubDescriptionTextView.textColor == GCMSAsset.Colors.gcmsGray4.color {
                    owner.clubDescriptionTextView.text = nil
                    owner.clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray1.color
                }
            }
            .disposed(by: disposeBag)
        
        clubDescriptionTextView.rx.didEndEditing
            .asObservable()
            .bind(with: self) { owner, _ in
                if owner.clubDescriptionTextView.text.isEmpty {
                    owner.clubDescriptionTextView.text = "동아리 설명을 입력해주세요."
                    owner.clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray4.color
                }
            }
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: UpdateClubReactor) {
        nextButton.rx.tap
            .map { Reactor.Action.secondNextButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let initialState = reactor.initialState
        
        clubNameTextField.text = initialState.title
        clubDescriptionTextView.text = initialState.description
        clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray1.color
        contactTextField.text = initialState.contact
        notionLinkTextField.text = initialState.notionLink
        teacherTextField.text = initialState.teacher
    }
}
