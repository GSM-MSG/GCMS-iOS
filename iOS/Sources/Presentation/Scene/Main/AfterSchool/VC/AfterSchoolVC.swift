import UIKit
import SnapKit
import Then
import ReactorKit
import RxSwift

final class AfterSchoolVC: BaseVC<AfterSchoolReactor>{
    
    private let searchController = UISearchController().then {
        $0.searchBar.placeholder = "검색어를 입력해주세요"
        $0.searchBar.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        $0.searchBar.barTintColor = .white
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "방과후 신청"
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 18)
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func configureNavigation() {
        self.navigationItem.titleView = titleLabel
        self.navigationItem.searchController = searchController
    }
}
