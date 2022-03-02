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
        let layout = UICollectionViewFlowLayout()
        
        $0.register(cellType: ClubListCell.self)
        $0.collectionViewLayout = layout
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(clubTypeSegmentedControl)
    }
    override func setLayoutSubviews() {
        clubTypeSegmentedControl.pin.top(view.pin.safeArea).pinEdges().horizontally(24%).height(19)
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
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
        
    }
}
