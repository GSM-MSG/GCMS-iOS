import UIKit
import SnapKit
import Then
import ReactorKit
import RxSwift

final class AfterSchoolVC: BaseVC<AfterSchoolReactor>{
    // MARK: - Properties
    private let searchController = UISearchController().then {
        $0.searchBar.placeholder = "검색어를 입력해주세요"
        $0.searchBar.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        $0.searchBar.tintColor = .white
        $0.searchBar.barTintColor = .white
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "방과후 신청"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    private let contourView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let searchFilter = UIButton().then {
        $0.setTitle("검색 필터", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.contentHorizontalAlignment = .center
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
    }
    
    private let afterSchoolNameLabel = SemiBoldTextLabel(title: "컴퓨터 활용 능력", weight: .semibold)
    
    private let periodLabel = SemiBoldTextLabel(title: "월요일 8,9교시", weight: .regular)
    
    private let gradeLabel = SemiBoldTextLabel(title: "1학년", weight: .semibold)
    
    private let participantsLabel = SemiBoldTextLabel(title: "17/30", weight: .semibold)

    private let applyButton = UIButton().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color 
        $0.layer.cornerRadius = 5
        $0.setTitle("신청", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        $0.contentHorizontalAlignment = .center
    }
    
    // MARK: - UI
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func configureNavigation() {
        self.navigationItem.titleView = titleLabel
        self.navigationItem.searchController = searchController
    }
    
    override func addView() {
        view.addSubViews(searchFilter, contourView, afterSchoolNameLabel, periodLabel, gradeLabel, participantsLabel, applyButton)
    }
    
    override func setLayout() {
        searchFilter.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(15)
            $0.height.equalTo(30)
        }
        contourView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(1.5)
            $0.top.equalTo(searchFilter.snp.bottom).offset(12)
        }
        afterSchoolNameLabel.snp.makeConstraints {
            $0.leading.equalTo(15)
            $0.height.equalTo(40)
            $0.width.equalTo(80)
            $0.top.equalTo(contourView.snp.bottom).offset(12)
        }
        periodLabel.snp.makeConstraints {
            $0.leading.equalTo(afterSchoolNameLabel).offset(75)
            $0.height.equalTo(40)
            $0.width.equalTo(97)
            $0.top.equalTo(afterSchoolNameLabel.snp.top)
        }
        gradeLabel.snp.makeConstraints {
            $0.leading.equalTo(periodLabel).offset(92)
            $0.height.equalTo(40)
            $0.width.equalTo(63)
            $0.top.equalTo(afterSchoolNameLabel.snp.top)
        }
        participantsLabel.snp.makeConstraints {
            $0.leading.equalTo(gradeLabel).offset(50)
            $0.height.equalTo(40)
            $0.width.equalTo(85)
            $0.top.equalTo(afterSchoolNameLabel.snp.top)
        }
        applyButton.snp.makeConstraints {
            $0.leading.equalTo(participantsLabel).offset(70)
            $0.height.equalTo(40)
            $0.width.equalTo(62)
            $0.top.equalTo(afterSchoolNameLabel.snp.top)
        }
    }
}
