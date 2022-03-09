import UIKit
import RxCocoa
import RxGesture
import RxSwift
import Reusable
import RxDataSources

final class NewClubVC: BaseVC<NewClubReactor> {
    // MARK: - Metric
    enum Metric {
        static let horizontalMargin: CGFloat = 15
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bannerLabel = HeaderLabel(title: "배너").then {
        $0.appendRequired()
    }
    private let bannerImageView = UIImageView().then {
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.image = GCMSAsset.Images.gcmsNewClubPlaceholder.image
    }
    private let clubNameLabel = HeaderLabel(title: "동아리 이름").then {
        $0.appendRequired()
    }
    private let clubNameTextField = NewClubTextField(placeholder: "동아리 이름을 입력해주세요.")
    private let clubDescriptionLabel = HeaderLabel(title: "동아리 소개").then {
        $0.appendRequired()
    }
    private let clubDescriptionTextView = UITextView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.backgroundColor = .clear
        $0.text = "동아리 소개를 입력해주세요."
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
        $0.textContainerInset = .init(top: 10, left: 5, bottom: 10, right: 5)
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
    }
    private let clubActivitiesLabel = HeaderLabel(title: "동아리 활동")
    private let clubActivityAppendButton = UIButton().then {
        $0.setImage(.init(systemName: "plus")?.tintColor(.white), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.clipsToBounds = true
    }
    private let clubActivitiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 80, height: 80)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(cellType: ClubActivityCell.self)
    }
    private let teacherLabel = HeaderLabel(title: "담당 선생님")
    private let teacherTextField = NewClubTextField(placeholder: "선생님 이름을 입력해주세요.")
    private let memberLabel = HeaderLabel(title: "동아리 구성원")
    private let memberAppendButton = UIButton().then {
        $0.setImage(.init(systemName: "plus")?.tintColor(.white), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.clipsToBounds = true
    }
    private let memberCountLabel = UILabel().then {
        $0.text = "0명"
        $0.textColor = GCMSAsset.Colors.gcmsGray3.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 12)
    }
    private let memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 61, height: 82)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(cellType: MemberCell.self)
    }
    private let contactLabel = HeaderLabel(title: "연락처")
    private let contactTextField = NewClubTextField(placeholder: "연락처를 입력해주세요.(디스코드, 전화번호 등)")
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
    }
    private let imagePicker = UIImagePickerController().then {
        $0.allowsEditing = true
        $0.sourceType = .photoLibrary
    }
    
    // MARK: - UI
    override func setup() {
        imagePicker.delegate = self
    }
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(
            bannerLabel, bannerImageView, clubNameLabel, clubNameTextField, clubDescriptionLabel, clubDescriptionTextView, clubActivitiesLabel, clubActivityAppendButton, clubActivitiesCollectionView, teacherLabel, teacherTextField, memberLabel, memberCountLabel, memberCollectionView, memberAppendButton, contactLabel, contactTextField, completeButton
        )
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()   
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        bannerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.equalToSuperview().offset(Metric.horizontalMargin)
        }
        bannerImageView.snp.makeConstraints {
            $0.top.equalTo(bannerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.width.equalTo(bound.width-30)
            $0.height.equalTo((bound.width-30)*0.6133)
        }
        clubNameLabel.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(45)
            $0.leading.equalTo(bannerImageView)
        }
        clubNameTextField.snp.makeConstraints {
            $0.top.equalTo(clubNameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(52)
        }
        clubDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(clubNameTextField.snp.bottom).offset(45)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
        }
        clubDescriptionTextView.snp.makeConstraints {
            $0.top.equalTo(clubDescriptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(100)
        }
        clubActivitiesLabel.snp.makeConstraints {
            $0.top.equalTo(clubDescriptionTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        clubActivityAppendButton.snp.makeConstraints {
            $0.centerY.equalTo(clubActivitiesLabel)
            $0.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(44)
        }
        clubActivitiesCollectionView.snp.makeConstraints {
            $0.top.equalTo(clubActivitiesLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(80)
        }
        teacherLabel.snp.makeConstraints {
            $0.top.equalTo(clubActivitiesCollectionView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        teacherTextField.snp.makeConstraints {
            $0.top.equalTo(teacherLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(52)
        }
        memberLabel.snp.makeConstraints {
            $0.top.equalTo(teacherTextField.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        memberAppendButton.snp.makeConstraints {
            $0.centerY.equalTo(memberLabel)
            $0.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(44)
        }
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(memberLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(82)
        }
        memberCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(memberCollectionView.snp.top)
        }
        contactLabel.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        contactTextField.snp.makeConstraints {
            $0.top.equalTo(contactLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(52)
        }
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contactTextField.snp.bottom).offset(50)
            $0.width.equalTo(166)
            $0.height.equalTo(33)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationItem.configTitle(title: "동아리 개설")
    }
    
    // MARK: - Reactor
    override func bindView(reactor: NewClubReactor) {
        clubDescriptionTextView.rx.text.asObservable()
            .compactMap { $0 }
            .withUnretained(self)
            .bind { owner, _ in
                let size = CGSize(width: owner.view.frame.width, height: .infinity)
                let esti = owner.clubDescriptionTextView.sizeThatFits(size)
                
                owner.clubDescriptionTextView.constraints.forEach { constraint in
                    if esti.height < 100 {}
                    else {
                        if constraint.firstAttribute == .height {
                            constraint.constant = esti.height
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        clubDescriptionTextView.rx.didBeginEditing
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                if owner.clubDescriptionTextView.textColor == GCMSAsset.Colors.gcmsGray4.color {
                    owner.clubDescriptionTextView.text = nil
                    owner.clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray1.color
                }
            }
            .disposed(by: disposeBag)
        
        clubDescriptionTextView.rx.didEndEditing
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                if owner.clubDescriptionTextView.text.isEmpty {
                    owner.clubDescriptionTextView.text = "동아리 소개를 입력해주세요."
                    owner.clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray4.color
                }
            }
            .disposed(by: disposeBag)
        
        clubActivityAppendButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.reactor?.action.onNext(.activityAppendButtonDidTap)
                owner.present(owner.imagePicker, animated: true)
            }
            .disposed(by: disposeBag)
        
        bannerImageView.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.reactor?.action.onNext(.bannerDidTap)
                owner.present(owner.imagePicker, animated: true)
            })
            .disposed(by: disposeBag)
        
        clubActivitiesCollectionView.rx.itemSelected
            .map(\.row)
            .map(Reactor.Action.activityDeleteDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        memberAppendButton.rx.tap
            .map { Reactor.Action.memberAppendButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        memberCollectionView.rx.itemSelected
            .map(\.row)
            .map(Reactor.Action.memberRemove)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
    }
    override func bindState(reactor: NewClubReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        let activityDS = RxCollectionViewSectionedReloadDataSource<ClubActivitySection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubActivityCell.self) as ClubActivityCell
            cell.model = item
            return cell
        }
        
        let memberDS = RxCollectionViewSectionedReloadDataSource<MemberSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: MemberCell.self) as MemberCell
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.imageData)
            .compactMap { $0 }
            .map { UIImage(data: $0) }
            .bind(with: self) { owner, image in
                owner.bannerImageView.image = image
            }
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.activitiesData)
            .map { [ClubActivitySection.init(items: $0)] }
            .bind(to: clubActivitiesCollectionView.rx.items(dataSource: activityDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.members)
            .do(onNext: { [weak self] item in
                self?.memberCountLabel.text = "\(item.count)명"
            }).map { [MemberSection.init(header: "", items: $0)] }
            .bind(to: memberCollectionView.rx.items(dataSource: memberDS))
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension
extension NewClubVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var imageData: Data = .init()
        if let editedImage = info[.editedImage] as? UIImage {
            imageData = editedImage.pngData() ?? .init()
        } else if let image = info[.originalImage] as? UIImage {
            imageData = image.pngData() ?? .init()
        }
        dismiss(animated: true) { [weak self] in
            self?.reactor?.action.onNext(.imageDidSelect(imageData))
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
