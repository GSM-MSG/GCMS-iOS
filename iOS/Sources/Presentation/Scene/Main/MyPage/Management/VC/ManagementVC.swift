import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable
import Service

final class ManagementVC : BaseVC<ManagementReactor> {
    // MARK: - Metric
    enum Metric {
        static let clubViewHegith = 205
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let majorLabel = UILabel().then {
        $0.text = "관리중인 전공 동아리"
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 16)
        $0.textColor = .white
    }
    
    private let editorialLabel = UILabel().then {
        $0.text = "관리중인 사설 동아리"
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 16)
        $0.textColor = .white
    }
    
    private let freedomLabel = UILabel().then {
        $0.text = "관리중인 자율 동아리"
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 16)
        $0.textColor = .white
    }
    
    private let clubAddButton = UIButton().then {
        $0.contentMode = .scaleToFill
        $0.setImage(UIImage(systemName: "plus")?.tintColor(.white), for: .normal)
        $0.setTitle("동아리 개설", for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 14)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
    }
    
    private lazy var barbutton = UIBarButtonItem(customView: clubAddButton)
        
    private let managementMajorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.register(cellType: ClubListCell.self)
        layout.itemSize = CGSize(width: 166, height: 205)
        $0.collectionViewLayout = layout
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    private let managementEditorialCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.register(cellType: ClubListCell.self)
        layout.itemSize = CGSize(width: 166, height: 205)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }
    
    private let managementFreedomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.register(cellType: ClubListCell.self)
        layout.itemSize = CGSize(width: 166, height: 205)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
    }
    
    // MARK: - UI
    
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(managementMajorCollectionView, managementEditorialCollectionView, managementFreedomCollectionView,majorLabel,editorialLabel,freedomLabel)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        majorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.right.equalToSuperview().inset(10)
        }
        managementMajorCollectionView.snp.makeConstraints {
            $0.top.equalTo(majorLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(10)
            $0.height.equalTo(Metric.clubViewHegith)
        }
        editorialLabel.snp.makeConstraints {
            $0.top.equalTo(managementMajorCollectionView.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(10)
        }
        managementEditorialCollectionView.snp.makeConstraints {
            $0.top.equalTo(editorialLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(10)
            $0.height.equalTo(Metric.clubViewHegith)
        }
        freedomLabel.snp.makeConstraints {
            $0.top.equalTo(managementEditorialCollectionView.snp.bottom).offset(35)
            $0.left.right.equalToSuperview().inset(10)
        }
        managementFreedomCollectionView.snp.makeConstraints {
            $0.top.equalTo(freedomLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(10)
            $0.height.equalTo(Metric.clubViewHegith)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    override func configureNavigation() {
        self.navigationController?.navigationBar.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = barbutton
        self.navigationItem.configBack()
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    
    override func bindAction(reactor: ManagementReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func bindState(reactor: ManagementReactor) {
        let sharedState = reactor.state.share(replay: 4).observe(on: MainScheduler.asyncInstance)

        let manageDS = RxCollectionViewSectionedReloadDataSource<ClubListSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubListCell
            cell.model = item
            return cell
        }
        let editorialDS = RxCollectionViewSectionedReloadDataSource<ClubListSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubListCell
            cell.model = item
            return cell
        }
        let freedomDS = RxCollectionViewSectionedReloadDataSource<ClubListSection>{ _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubListCell
            cell.model = item
            return cell
        }

        sharedState
            .map(\.majorList)
            .bind(to: managementMajorCollectionView.rx.items(dataSource: manageDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.editorialList)
            .bind(to: managementEditorialCollectionView.rx.items(dataSource: editorialDS))
            .disposed(by: disposeBag)

        sharedState
            .map(\.freedomList)
            .bind(to: managementFreedomCollectionView.rx.items(dataSource: freedomDS))
            .disposed(by: disposeBag)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: ManagementReactor) {
        clubAddButton.rx.tap
            .map { Reactor.Action.newClubButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
    }
}
