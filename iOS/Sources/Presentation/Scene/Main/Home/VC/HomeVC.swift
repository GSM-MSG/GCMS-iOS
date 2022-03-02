import UIKit
import SnapKit
import PinLayout
import RxSwift
import RxCocoa
import RxDataSources
import Reusable

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
    }
    override func addView() {
        view.addSubViews(clubTypeSegmentedControl, clubListCollectionView)
    }
    override func setLayoutSubviews() {
        clubTypeSegmentedControl.pin.top(view.pin.safeArea).pinEdges().horizontally(24%).height(33)
        clubListCollectionView.pin.top(view.pin.safeArea.top + 33).horizontally(10).bottom(view.pin.safeArea)
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationItem.setLeftBarButton(myPageButton, animated: true)
        self.navigationItem.setRightBarButton(alarmButton, animated: true)
        
    }
    // MARK: - Reactor
    override func bindAction(reactor: HomeReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: HomeReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let ds = RxCollectionViewSectionedReloadDataSource<ClubListSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubListCell
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.clubList)
            .bind(to: clubListCollectionView.rx.items(dataSource: ds))
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
