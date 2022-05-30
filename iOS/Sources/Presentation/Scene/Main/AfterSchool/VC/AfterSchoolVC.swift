import UIKit
import SnapKit
import Then
import ReactorKit
import RxSwift

final class AfterSchoolVC: BaseVC<AfterSchoolReactor> {
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
    private let searchFilterButton = UIButton().then {
        $0.setTitle("검색 필터", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.contentHorizontalAlignment = .center
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
    }
    private let afterSchoolTableView = UITableView().then {
        $0.register(cellType: AfterSchoolTableViewCell.self)
        $0.rowHeight = 41
        $0.separatorStyle = .none
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
        view.addSubViews(searchFilterButton, contourView, afterSchoolTableView)
    }
    
    override func setLayout() {
        searchFilterButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview().inset(15)
            $0.height.equalTo(30)
        }
        contourView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(1.5)
            $0.top.equalTo(searchFilterButton.snp.bottom).offset(12)
        }
        afterSchoolTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(contourView.snp.bottom).offset(12)
        }
    }
    // MARK: - Reactor
    
    override func bindView(reactor: AfterSchoolReactor) {
        searchFilterButton.rx.tap
            .map { Reactor.Action.searchFilterButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}
