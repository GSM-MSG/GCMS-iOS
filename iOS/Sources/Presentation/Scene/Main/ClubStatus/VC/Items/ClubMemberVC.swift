import UIKit
import Reusable
import Then
import SnapKit

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
            $0.edges.equalToSuperview()
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
}
