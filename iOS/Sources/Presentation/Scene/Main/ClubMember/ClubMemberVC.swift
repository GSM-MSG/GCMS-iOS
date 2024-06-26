import UIKit
import Configure
import Reusable
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Service

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
        clubOpenCloseButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.bottom + 72)
        }
        membersTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(clubOpenCloseButton.snp.top)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        clubOpenCloseButton.isHidden = !isHead
    }

    // MARK: - Reactor
    override func bindAction(reactor: ClubMemberReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: ClubMemberReactor) {
        clubOpenCloseButton.rx.tap
            .map { Reactor.Action.clubOpenCloseButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: ClubMemberReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)

        sharedState
            .map(\.isOpened)
            .map { $0 ? "동아리 신청 마감하기" : "동아리 신청 받기" }
            .bind(to: clubOpenCloseButton.rx.title())
            .disposed(by: disposeBag)

        sharedState
            .map(\.users)
            .bind(with: self) { owner, _ in
                owner.membersTableView.reloadData()
            }
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
            cell.delegate = self
            return cell
        case let .member(member):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: StatusMemberCell.self)
            cell.isHead = isHead
            cell.model = member
            cell.delegate = self
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

        membersTableView.reloadSections(.init([section]), with: .automatic)
    }
}

extension ClubMemberVC: ApplicantCellDelegate, StatusMemberCellDelegate {
    func acceptButtonDidTap(user: User) {
        reactor?.action.onNext(.acceptButtonDidTap(user))
    }

    func rejectButtonDidTap(user: User) {
        reactor?.action.onNext(.rejectButtonDidTap(user))
    }

    func kicktButtonDidTap(user: Member) {
        reactor?.action.onNext(.kickButtonDidTap(user))
    }

    func delegationButtonDidTap(user: Member) {
        reactor?.action.onNext(.delegationButtonDidTap(user))
    }

}
