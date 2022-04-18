import UIKit
import Reusable
import Then
import SnapKit
import RxSwift
import RxDataSources

final class ClubMemberVC: BaseVC<ClubStatusReactor> {
    // MARK: - Properties
    private let isHead: Bool
    private let clubMemberTableView = UITableView().then {
        $0.register(cellType: StatusMemberCell.self)
        $0.backgroundColor = .clear
    }
    
    // MARK: - Init
    init(reactor: ClubStatusReactor, isHead: Bool) {
        self.isHead = isHead
        super.init(reactor: reactor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(clubMemberTableView)
    }
    override func setLayout() {
        clubMemberTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(65)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    override func bindState(reactor: ClubStatusReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let memberDS = RxTableViewSectionedReloadDataSource<StatusMemberSection> { [weak self] _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: StatusMemberCell.self)
            cell.model = item
            cell.isHead = self?.isHead ?? false
            return cell
        }
        
        sharedState
            .map(\.members)
            .map { [StatusMemberSection.init(items: $0)] }
            .bind(to: clubMemberTableView.rx.items(dataSource: memberDS))
            .disposed(by: disposeBag)
            
    }
}
