import UIKit
import SnapKit
import Reusable
import RxGesture
import RxSwift
import RxDataSources
import PhotosUI
import MSGLayout

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
        scrollView.addSubViews(progressBar, bannerImageView, bannerHeaderLabel, clubActivitiesHeaderLabel, clubActivitiesCollectionView, clubActivityAppendButton, clubMemberCollectionView, clubMemberCountLabel, clubMemberHeaderLabel, clubMemberAppendButton)
    }
    override func setLayout() {
        MSGLayout.buildLayout {
            scrollView.layout
                .top(.to(view.safeAreaLayoutGuide))
                .horizontal(.toSuperview())
                .bottom(.toSuperview())

            progressBar.layout
                .top(.toSuperview(), .equal(40))
                .centerX(.toSuperview())
                .horizontal(.toSuperview(), .equal(35))
                .height(30)

            bannerImageView.layout
                .top(.to(progressBar).bottom, .equal(115))
                .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                .height((bound.width-40)*0.6625)

            bannerHeaderLabel.layout
                .left(.to(bannerImageView))
                .bottom(.to(bannerImageView).top, .equal(-8))

            clubActivitiesCollectionView.layout
                .top(.to(bannerImageView).bottom, .equal(Metric.verticalSpacing))
                .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                .height(80)

            clubActivitiesHeaderLabel.layout
                .leading(.to(clubActivitiesCollectionView).leading)
                .bottom(.to(clubActivitiesCollectionView).top, .equal(-8))

            clubActivityAppendButton.layout
                .trailing(.to(clubActivitiesCollectionView).trailing)
                .centerY(.to(clubActivitiesHeaderLabel))
                .size(Metric.buttonSize)

            clubMemberCollectionView.layout
                .horizontal(.toSuperview(), .equal(Metric.horizontalMargin))
                .top(.to(clubActivitiesCollectionView).bottom, .equal(Metric.verticalSpacing))
                .height(82)
                .bottom(.toSuperview(), .equal(-70))

            clubMemberHeaderLabel.layout
                .leading(.to(clubMemberCollectionView).leading)
                .bottom(.to(clubMemberCollectionView).top, .equal(-8))

            clubMemberCountLabel.layout
                .centerX(.toSuperview())
                .centerY(.to(clubMemberHeaderLabel))

            clubMemberAppendButton.layout
                .trailing(.to(clubMemberCollectionView))
                .bottom(.to(clubMemberCollectionView).top, .equal(-8))
                .size(Metric.buttonSize)

            completeButton.layout
                .horizontal(.toSuperview())
                .bottom(.toSuperview())
                .height(view.safeAreaInsets.bottom + 72)
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
    override func bindState(reactor: UpdateClubReactor) {
        let sharedState = reactor.state.share(replay: 4).observe(on: MainScheduler.asyncInstance)

        let activityDS = RxCollectionViewSectionedReloadDataSource<ClubActivitySection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubActivityCell.self) as ClubActivityCell
            cell.model = item
            return cell
        }

        let memberDS = RxCollectionViewSectionedReloadDataSource<ClubMemberSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubMemberCell.self) as ClubMemberCell
            cell.model = item
            return cell
        }

        sharedState
            .map(\.bannerImg)
            .compactMap { $0 }
            .map { UIImage(data: $0) }
            .bind(to: bannerImageView.rx.image)
            .disposed(by: disposeBag)

        sharedState
            .map(\.activityImgs)
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
