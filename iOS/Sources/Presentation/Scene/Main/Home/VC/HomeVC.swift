import UIKit
import SnapKit
import PinLayout
import RxSwift
import RxCocoa
import RxDataSources

final class HomeVC: BaseVC<HomeReactor> {
    // MARK: - Properties
    private let clubTypeSegmentedControl = ClubTypeSegmentedControl(titles: ["전공", "사설", "자율"])
    
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
        
    }
    override func bindState(reactor: HomeReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        
    }
}
