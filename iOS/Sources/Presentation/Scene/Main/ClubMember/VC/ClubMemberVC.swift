import UIKit
import Then
import Reusable
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

final class ClubMemberVC: BaseVC<ClubMemberReactor> {
    // MARK: - Properties
    private let membersTableView = UITableView().then {
        $0.register(cellType: ApplicantCell.self)
        $0.register(cellType: StatusMemberCell.self)
        $0.register(headerFooterViewType: MemberHeaderView.self)
        $0.estimatedRowHeight = 40
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    private let clubOpenCloseButton = UIButton().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.setTitleColor(.white, for: .normal)
    }
    private let isHead: Bool
    
    init(reactor: ClubMemberReactor?, isHead: Bool) {
        self.isHead = isHead
        super.init(reactor: reactor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    override func setup() {
        membersTableView.delegate = self
        membersTableView.dataSource = self
    }
    override func addView() {
        view.addSubViews(membersTableView, clubOpenCloseButton)
    }
    override func setLayout() {
        membersTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        clubOpenCloseButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.bottom + 56)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: ClubMemberReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

extension ClubMemberVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let reactor = reactor else { return 0 }
        return reactor.currentState.users.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let reactor = reactor?.currentState else { return 0 }
        return reactor.users[section].isOpened ? reactor.users[section].items.count : 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let reactor = reactor else { return .init() }
        let header = tableView.dequeueReusableHeaderFooterView(MemberHeaderView.self)
        header?.section = section
        header?.model = reactor.currentState.users[section].header
        header?.setIsOpened(isOpen: reactor.currentState.users[section].isOpened)
        header?.delegate = self
        return header
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = reactor?.currentState.users[indexPath.section].items[indexPath.row] else { return .init() }
        switch item {
        case let .applicant(user):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ApplicantCell.self)
            cell.isHead = isHead
            cell.model = user
            return cell
        case let .member(member):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: StatusMemberCell.self)
            cell.isHead = isHead
            cell.model = member
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let reactor = reactor else { return .init() }
        return reactor.currentState.users[indexPath.section].isOpened ? UITableView.automaticDimension : 0
    }
}

extension ClubMemberVC: MemberHeaderViewDelegate {
    func toggleSection(header: MemberHeaderView, section: Int) {
        guard let reactor = reactor else { return  }
        let opened = !reactor.currentState.users[section].isOpened
        reactor.action.onNext(.sectionDidTap(section, opened))
        header.setIsOpened(isOpen: opened)
        
        membersTableView.reloadSections(.init([section]), with: .automatic)
    }
}
