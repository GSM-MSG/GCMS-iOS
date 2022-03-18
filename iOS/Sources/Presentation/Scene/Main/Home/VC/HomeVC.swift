import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable
import Service

final class HomeVC: BaseVC<HomeReactor> {
    // MARK: - Properties
    private let clubTypeSegmentedControl = ClubTypeSegmentedControl(titles: ["전공", "사설", "자율"])
    private let clubListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.register(cellType: ClubListCell.self)
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    private let myPageButton = UIBarButtonItem(image: .init(systemName: "person.circle")?.tintColor(GCMSAsset.Colors.gcmsGray4.color),
                                               style: .plain,
                                               target: nil,
                                               action: nil)
    private let alarmButton = UIBarButtonItem(image: .init(systemName: "bell")?.tintColor(GCMSAsset.Colors.gcmsGray4.color),
                                              style: .plain,
                                              target: nil,
                                              action: nil)
    
    // MARK: - UI
    override func setup() {
        let lay = GCMSLayout()
        lay.delegate = self
        clubListCollectionView.collectionViewLayout = lay
        clubTypeSegmentedControl.delegate = self
    }
    override func addView() {
        view.addSubViews(clubTypeSegmentedControl, clubListCollectionView)
    }
    override func setLayoutSubviews() {
        clubTypeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(33)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.24)
        }
        clubListCollectionView.snp.makeConstraints {
            $0.top.equalTo(clubTypeSegmentedControl.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(myPageButton, animated: true)
        self.navigationItem.setRightBarButton(alarmButton, animated: true)
        self.navigationItem.configTitleImage()
        self.navigationItem.configBack()
        self.navigationController?.navigationBar.setClear()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: HomeReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: HomeReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let ds = RxCollectionViewSectionedReloadDataSource<ClubListSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubListCell
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.clubList)
            .bind(to: clubListCollectionView.rx.items(dataSource: ds))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: HomeReactor) {
        myPageButton.rx.tap
            .map { Reactor.Action.myPageButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        alarmButton.rx.tap
            .map { Reactor.Action.alarmButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}

// MARK: - Extension
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, GCMSLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemIndexAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 190
        } else {
            return 250
        }
    }
}

extension HomeVC: ClubTypeSegmentedControlDelegate {
    func segmentValueChanged(to index: Int) {
        var type: ClubType = .major
        switch index {
        case 0: type = .major
        case 1: type = .editorial
        case 2: type = .freedom
        default: type = .major
        }
        reactor?.action.onNext(.segmentDidTap(type))
    }
}
