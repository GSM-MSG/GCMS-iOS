import UIKit
import Reusable
import SnapKit
import RxSwift
import RxDataSources

final class AlarmVC: BaseVC<AlarmReactor> {
    // MARK: - Properties
    private let alarmTableView = UITableView().then {
        $0.register(cellType: AlarmCell.self)
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(alarmTableView)
    }
    override func setLayout() {
        alarmTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationItem.configTitle(title: "알림")
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: AlarmReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: AlarmReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let ds = RxTableViewSectionedReloadDataSource<AlarmSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as AlarmCell
            cell.model = item
            return cell
        }
        sharedState
            .map(\.alarmList)
            .map { [AlarmSection.init(header: "", items: $0)] }
            .bind(to: alarmTableView.rx.items(dataSource: ds))
            .disposed(by: disposeBag)
            
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}
