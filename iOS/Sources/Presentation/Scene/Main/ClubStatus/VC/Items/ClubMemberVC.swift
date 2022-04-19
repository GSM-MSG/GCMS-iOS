import UIKit
import Reusable
import Then
import SnapKit
import RxSwift
import RxDataSources
import Service

final class ClubMemberVC: BaseVC<ClubStatusReactor> {
    // MARK: - Properties
    private let isHead: Bool
    private let clubMemberTableView = UITableView().then {
        $0.register(cellType: StatusMemberCell.self)
        $0.backgroundColor = .clear
        $0.rowHeight = 60
        $0.separatorStyle = .none
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
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        let memberDS = RxTableViewSectionedReloadDataSource<StatusMemberSection> { [weak self] _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: StatusMemberCell.self)
            cell.model = item
            cell.isHead = self?.isHead ?? false
            cell.delegate = self
            return cell
        }
        
        sharedState
            .map(\.members)
            .map { [StatusMemberSection.init(items: $0)] }
            .bind(to: clubMemberTableView.rx.items(dataSource: memberDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, item in
                item ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}

extension ClubMemberVC: StatusMemberCellDelegate {
    func kicktButtonDidTap(user: Member) {
        
    }
    func delegationButtonDidTap(user: Member) {
        
    }
}
