import UIKit
import SnapKit
import PinLayout

final class HomeVC: BaseVC<HomeReactor> {
    // MARK: - Properties
    private let clubTypeSegmentedControl = ClubTypeSegmentedControl(titles: ["전공", "사설", "자율"])
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(clubTypeSegmentedControl)
    }
    override func setLayout() {
        clubTypeSegmentedControl.pin.top(view.pin.safeArea).pinEdges().horizontally(24%).height(19)
        
        
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
}
