import UIKit
import Reusable
import Then
import SnapKit

final class ClubApplicantsVC: BaseVC<ClubStatusReactor> {
    // MARK: - Properties
    private let applicantTableView = UITableView().then {
        $0.register(cellType: ApplicantCell.self)
        $0.backgroundColor = .clear
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(applicantTableView)
    }
    override func setLayout() {
        applicantTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
}
