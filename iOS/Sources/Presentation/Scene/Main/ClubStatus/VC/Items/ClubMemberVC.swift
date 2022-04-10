import UIKit
import Reusable
import Then
import SnapKit

final class ClubMemberVC: BaseVC<ClubStatusReactor> {
    // MARK: - Properties
    private let clubMemberTableView = UITableView().then {
        $0.register(cellType: StatusMemberCell.self)
        $0.backgroundColor = .clear
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
