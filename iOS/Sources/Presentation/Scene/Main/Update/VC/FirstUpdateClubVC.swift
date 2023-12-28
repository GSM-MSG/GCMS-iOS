import UIKit
 import IQKeyboardManagerSwift
 import SnapKit
 import RxKeyboard
 import RxSwift
 import MSGLayout

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
         MSGLayout.buildLayout {
             scrollView.layout
                 .top(.to(view.safeAreaLayoutGuide))
                 .bottom(.toSuperview())
                 .horizontal(.toSuperview())

             progressBar.layout
                 .top(.toSuperview(), .equal(40))
                 .centerX(.toSuperview())
                 .horizontal(.toSuperview(), .equal(35))
                 .height(30)

             clubNameTextField.layout
                 .top(.to(progressBar).bottom, .equal(115))
                 .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                 .height(Metric.textFieldHeight)

             clubDescriptionTextView.layout
                 .top(.to(clubNameTextField).bottom, .equal(Metric.verticalSpacing))
                 .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                 .height(90)

             clubDescriptionHeaderLabel.layout
                 .leading(.to(clubDescriptionTextView).leading)
                 .bottom(.to(clubDescriptionTextView).top, .equal(-8))

             contactTextField.layout
                 .top(.to(clubDescriptionTextView).bottom, .equal(Metric.verticalSpacing))
                 .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                 .height(Metric.textFieldHeight)

             notionLinkTextField.layout
                 .top(.to(contactTextField).bottom, .equal(Metric.verticalSpacing))
                 .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                 .height(Metric.textFieldHeight)

             notionLinkHeaderLabel.layout
                 .leading(.to(notionLinkTextField).leading)
                 .bottom(.to(notionLinkTextField).top, .equal(-8))

             teacherTextField.layout
                 .top(.to(notionLinkTextField).bottom, .equal(Metric.verticalSpacing))
                 .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                 .height(Metric.textFieldHeight)
                 .bottom(.toSuperview(), .equal(-70))

             nextButton.layout
                 .bottom(.toSuperview())
                 .horizontal(.toSuperview())
                 .height(view.safeAreaInsets.bottom + 72)
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
                 if owner.clubDescriptionTextView.text == nil {
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

         self.clubNameTextField.text = initialState.name
         self.clubDescriptionTextView.text = initialState.content
         self.clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray1.color
         self.contactTextField.text = initialState.contact
         self.notionLinkTextField.text = initialState.notionLink
         self.teacherTextField.text = initialState.teacher
     }
 }
