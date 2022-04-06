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
    
    // MARK: - UI
    override func setup() {
        let lay = GCMSLayout()
        lay.delegate = self
        clubListCollectionView.collectionViewLayout = lay
    }
    override func addView() {
        view.addSubViews(clubListCollectionView)
    }
    override func setLayout() {
        clubListCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: HomeReactor) {
        clubListCollectionView.rx.modelSelected(ClubList.self)
            .map { Reactor.Action.clubDidTap(.init(name: $0.title, type: $0.type)) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: HomeReactor) {
        let ds = RxCollectionViewSectionedReloadDataSource<ClubListSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ClubListCell.self)
            cell.model = item
            return cell
        }
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.freedomClubList)
            .map { [ClubListSection.init(header: "", items: $0)] }
            .bind(to: clubListCollectionView.rx.items(dataSource: ds))
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
