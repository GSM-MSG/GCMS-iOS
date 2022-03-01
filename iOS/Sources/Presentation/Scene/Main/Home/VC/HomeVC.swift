import UIKit
import SnapKit

final class HomeVC: BaseVC<HomeReactor> {
    // MARK: - Properties
    private let clubTypeSegmentedControl = ClubTypeSegmentedControl(titles: ["전공", "사설", "자율"])
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(clubTypeSegmentedControl)
    }
    override func setLayout() {
        clubTypeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(bound.width*0.24)
            $0.height.equalTo(19)
        }
        
    }
}
