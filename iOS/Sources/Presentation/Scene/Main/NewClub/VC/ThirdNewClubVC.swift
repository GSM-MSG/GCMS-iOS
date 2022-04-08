import UIKit
import SnapKit
import Reusable
import RxGesture
import RxSwift
import RxDataSources

final class ThirdNewClubVC: BaseVC<NewClubReactor> {
    // MARK: - Metric
    enum Metric {
        static let verticalSpacing: CGFloat = 65
        static let horizontalMargin: CGFloat = 20
        static let buttonSize: CGFloat = 30
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let progressBar = NewClubSteppedProgressBar(selectedIndex: 2)
    private let bannerHeaderLabel = HeaderLabel(title: "동아리 배너")
    private let bannerImageView = UIImageView().then {
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.image = GCMSAsset.Images.gcmsNewClubPlaceholder.image
    }
    private let clubActivitiesHeaderLabel = HeaderLabel(title: "동아리 사진").then {
        $0.appendSelection()
    }
    private let clubActivitiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 80, height: 80)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(cellType: ClubActivityCell.self)
    }
    private let clubActivityAppendButton = NewClubAppendButton()
    private let clubMemberHeaderLabel = HeaderLabel(title: "동아리 구성원").then {
        $0.appendSelection()
    }
    private let clubMemberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 61, height: 82)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(cellType: ClubMemberCell.self)
    }
    private let clubMemberCountLabel = UILabel().then {
        $0.text = "0명"
        $0.textColor = GCMSAsset.Colors.gcmsGray3.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 12)
    }
    private let clubMemberAppendButton = NewClubAppendButton()
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
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
        view.addSubViews(scrollView, completeButton)
        scrollView.addSubViews(progressBar, bannerImageView, bannerHeaderLabel, clubActivitiesHeaderLabel, clubActivitiesCollectionView, clubActivityAppendButton, clubMemberHeaderLabel, clubMemberCountLabel, clubMemberAppendButton, clubMemberCollectionView)
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
        bannerImageView.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(115)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo((bound.width-40)*0.6625)
        }
        bannerHeaderLabel.snp.makeConstraints {
            $0.leading.equalTo(bannerImageView)
            $0.bottom.equalTo(bannerImageView.snp.top).offset(-8)
        }
        clubActivitiesCollectionView.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(Metric.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(80)
        }
        clubActivitiesHeaderLabel.snp.makeConstraints {
            $0.leading.equalTo(clubActivitiesCollectionView)
            $0.bottom.equalTo(clubActivitiesCollectionView.snp.top).offset(-8)
        }
        clubActivityAppendButton.snp.makeConstraints {
            $0.trailing.equalTo(clubActivitiesCollectionView)
            $0.centerY.equalTo(clubActivitiesHeaderLabel)
            $0.size.equalTo(Metric.buttonSize)
        }
        clubMemberCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.top.equalTo(clubActivitiesCollectionView.snp.bottom).offset(Metric.verticalSpacing)
            $0.height.equalTo(82)
            $0.bottom.equalToSuperview().offset(-71)
        }
        clubMemberHeaderLabel.snp.makeConstraints {
            $0.leading.equalTo(clubMemberCollectionView)
            $0.bottom.equalTo(clubMemberCollectionView.snp.top).offset(-8)
        }
        clubMemberCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(clubMemberHeaderLabel)
        }
        clubMemberAppendButton.snp.makeConstraints {
            $0.trailing.equalTo(clubMemberCollectionView)
            $0.bottom.equalTo(clubMemberCollectionView.snp.top).offset(-8)
            $0.size.equalTo(Metric.buttonSize)
        }
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.bottom + 56)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: NewClubReactor) {
        bannerImageView.rx.tapGesture()
            .when(.recognized)
            .bind(with: self) { owner, _ in
                owner.reactor?.action.onNext(.bannerDidTap)
                owner.present(owner.imagePicker, animated: true)
            }
            .disposed(by: disposeBag)
        
        clubActivityAppendButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.reactor?.action.onNext(.activityAppendButtonDidTap)
                owner.present(owner.imagePicker, animated: true)
            }
            .disposed(by: disposeBag)
        
        clubActivitiesCollectionView.rx.itemSelected
            .map(\.row)
            .map(Reactor.Action.activityDeleteDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        clubMemberAppendButton.rx.tap
            .map { Reactor.Action.memberAppendButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        clubMemberCollectionView.rx.itemSelected
            .map(\.row)
            .map(Reactor.Action.memberRemove)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .map { Reactor.Action.completeButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: NewClubReactor) {
        let sharedState = reactor.state.share(replay: 4).observe(on: MainScheduler.asyncInstance)
        
        let activityDS = RxCollectionViewSectionedReloadDataSource<ClubActivitySection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubActivityCell.self) as ClubActivityCell
            cell.model = item
            return cell
        }
        
        let memberDS = RxCollectionViewSectionedReloadDataSource<ClubMemberSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubMemberCell.self) as ClubMemberCell
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.imageData)
            .compactMap { $0 }
            .map { UIImage(data: $0) }
            .bind(to: bannerImageView.rx.image)
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.activitiesData)
            .map { [ClubActivitySection.init(items: $0)] }
            .bind(to: clubActivitiesCollectionView.rx.items(dataSource: activityDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.members)
            .do(onNext: { [weak self] item in
                self?.clubMemberCountLabel.text = "\(item.count)명"
            }).map { [ClubMemberSection.init(header: "", items: $0)] }
            .bind(to: clubMemberCollectionView.rx.items(dataSource: memberDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}

extension ThirdNewClubVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
