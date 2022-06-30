import UIKit
import SnapKit
import Reusable
import RxGesture
import RxSwift
import RxDataSources
import PhotosUI

final class SecondUpdateClubVC: BaseVC<UpdateClubReactor> {
    // MARK: - Metric
    enum Metric {
        static let verticalSpacing: CGFloat = 65
        static let horizontalMargin: CGFloat = 20
        static let buttonSize: CGFloat = 30
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let progressBar = UpdateSteppedProgressBar(selectedIndex: 1)
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
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
    }
    
    private var bannerPHConfiguration: PHPickerConfiguration = {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        return config
    }()
    private lazy var bannerPHPickerController = PHPickerViewController(configuration: bannerPHConfiguration)
    
    private var activityPHConfiguration: PHPickerConfiguration = {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 4
        return config
    }()
    private lazy var activityPHPickerController = PHPickerViewController(configuration: activityPHConfiguration)
    
    // MARK: - UI
    override func setup() {
        [bannerPHPickerController, activityPHPickerController].forEach { $0.delegate = self }
    }
    override func addView() {
        view.addSubViews(scrollView, completeButton)
        scrollView.addSubViews(progressBar, bannerImageView, bannerHeaderLabel, clubActivitiesHeaderLabel, clubActivitiesCollectionView, clubActivityAppendButton)
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
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.bottom + 72)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: UpdateClubReactor) {
        bannerImageView.rx.tapGesture()
            .when(.recognized)
            .bind(with: self) { owner, _ in
                owner.reactor?.action.onNext(.bannerDidTap)
                owner.present(owner.bannerPHPickerController, animated: true)
            }
            .disposed(by: disposeBag)
        
        clubActivityAppendButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.reactor?.action.onNext(.activityAppendButtonDidTap)
                owner.present(owner.activityPHPickerController, animated: true)
            }
            .disposed(by: disposeBag)
        
        clubActivitiesCollectionView.rx.itemSelected
            .map(\.row)
            .map(Reactor.Action.activityDeleteDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .map { Reactor.Action.completeButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: UpdateClubReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)
        
        let activityDS = RxCollectionViewSectionedReloadDataSource<ClubActivitySection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubActivityCell.self) as ClubActivityCell
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
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}

extension SecondUpdateClubVC: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        picker.dismiss(animated: true)
        let providers = results.compactMap { $0.itemProvider }
        providers.forEach { provider in
            provider.loadDataRepresentation(forTypeIdentifier: "public.image") { [weak self] data, err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                if let data = data {
                    self?.reactor?.action.onNext(.imageDidSelect(data))
                }
            }
        }
    }
}
