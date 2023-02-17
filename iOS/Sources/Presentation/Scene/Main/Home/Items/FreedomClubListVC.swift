import UIKit
import RxDataSources
import RxSwift
import Service

final class FreedomClubListVC: BaseVC<HomeReactor> {
    // MARK: - Properties
    private let clubListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.register(cellType: ClubListCell.self)
        $0.backgroundColor = .clear
    }
    private let refreshControl = UIRefreshControl()

    // MARK: - UI
    override func setup() {
        let lay = GCMSLayout()
        lay.delegate = self
        clubListCollectionView.collectionViewLayout = lay
        clubListCollectionView.refreshControl = refreshControl
    }
    override func addView() {
        view.addSubViews(clubListCollectionView)
    }
    override func setLayout() {
        clubListCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }

    // MARK: - Reactor
    override func bindView(reactor: HomeReactor) {
        clubListCollectionView.rx.modelSelected(ClubList.self)
            .map(\.id)
            .map(Reactor.Action.clubDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged)
            .map { Reactor.Action.refreshTrigger(.freedom) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: HomeReactor) {
        let ds = RxCollectionViewSectionedReloadDataSource<ClubListSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubListCell.self)
            cell.model = item
            return cell
        }
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)

        sharedState
            .map(\.freedomClubList)
            .do(afterNext: { [weak self] _ in
                self?.clubListCollectionView.reloadData()
                self?.clubListCollectionView.collectionViewLayout.invalidateLayout()
            })
            .map { [ClubListSection.init(header: "", items: $0)] }
            .bind(to: clubListCollectionView.rx.items(dataSource: ds))
            .disposed(by: disposeBag)

        sharedState
            .map(\.isRefreshing)
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
    override func bindAction(reactor: HomeReactor) {
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.viewDidAppear(.freedom) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

extension FreedomClubListVC: GCMSLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemIndexAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 190
        } else {
            return 250
        }
    }
}
