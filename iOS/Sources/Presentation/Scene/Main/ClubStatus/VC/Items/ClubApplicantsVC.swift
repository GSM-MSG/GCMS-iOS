import UIKit
import Reusable
import Then
import SnapKit

final class ClubApplicantsVC: BaseVC<ClubStatusReactor> {
    // MARK: - Properties
    private let isHead: Bool
    private let applicantTableView = UITableView().then {
        $0.register(cellType: ApplicantCell.self)
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
