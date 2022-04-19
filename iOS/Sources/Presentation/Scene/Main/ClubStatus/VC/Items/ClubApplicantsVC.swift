import UIKit
import Reusable
import Then
import SnapKit
import RxSwift
import RxDataSources
import Service

final class ClubApplicantsVC: BaseVC<ClubStatusReactor> {
    // MARK: - Properties
    private let isHead: Bool
    private let applicantTableView = UITableView().then {
        $0.register(cellType: ApplicantCell.self)
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
        view.addSubViews(applicantTableView)
    }
    override func setLayout() {
        applicantTableView.snp.makeConstraints {
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
        
        let applicantDS = RxTableViewSectionedReloadDataSource<ApplicantSection> { [weak self] _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: ApplicantCell.self)
            cell.model = item
            cell.isHead = self?.isHead ?? false
            cell.delegate = self
            return cell
        }
        
        sharedState
            .map(\.applicants)
            .map { [ApplicantSection.init(items: $0)] }
            .bind(to: applicantTableView.rx.items(dataSource: applicantDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, item in
                item ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}

extension ClubApplicantsVC: ApplicantCellDelegate {
    func acceptButtonDidTap(user: User) {
        
    }
    func rejectButtonDidTap(user: User) {
        
    }
}
