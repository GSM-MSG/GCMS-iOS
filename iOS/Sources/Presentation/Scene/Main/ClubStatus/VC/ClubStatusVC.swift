import UIKit
import Reusable
import SnapKit

final class ClubStatusVC: BaseVC<ClubStatusReactor> {
    // MARK: - Properties
    private let clubStatusSegmentedControl = ClubStatusSegmentedControl()
    private let applicantCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let flowLayout = UICollectionViewFlowLayout()
        $0.collectionViewLayout = flowLayout
        $0.register(cellType: ApplicantCell.self)
    }
    private let clubMemberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let flowLayout = UICollectionViewFlowLayout()
        $0.collectionViewLayout = flowLayout
        $0.register(cellType: ClubMemberCell.self)
    }
    private let openButton = UIButton()
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(clubStatusSegmentedControl, applicantCollectionView, clubMemberCollectionView, openButton)
    }
    override func setLayout() {
        
    }
}
