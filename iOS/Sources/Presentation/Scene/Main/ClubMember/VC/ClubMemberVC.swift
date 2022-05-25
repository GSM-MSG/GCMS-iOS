import UIKit
import ExpyTableView
import Then
import Reusable
import SnapKit
import RxSwift
import RxCocoa

final class ClubMemberVC: BaseVC<ClubMemberReactor> {
    // MARK: - Properties
    private let membersTableView = UITableView().then {
        $0.register(cellType: ApplicantCell.self)
        $0.register(cellType: StatusMemberCell.self)
        $0.estimatedRowHeight = 40
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
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
        membersTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    override func addView() {
        view.addSubViews(membersTableView)
    }
    override func setLayout() {
        membersTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
}

extension ClubMemberVC: UITableViewDelegate {
    
}
