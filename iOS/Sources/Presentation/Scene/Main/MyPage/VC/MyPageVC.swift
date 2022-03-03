import UIKit
import Reusable
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class MyPageVC: BaseVC<MyPageReactor> {
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let userProfileImageView = UIImageView().then {
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }
    private let usernameLabel = UILabel().then {
        $0.text = "ASDF"
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.textAlignment = .center
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 14)
    }
    private let classLabel = UILabel().then {
        $0.text = "ASDFASDF"
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
        $0.textAlignment = .center
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
    }
    private let managementButton = UIButton().then {
        $0.setTitle("동아리 관리하기", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 12)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    private let editorialLabel = HeaderLabel(title: "내가 속한 사설 동아리")
    private let editorialCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.itemSize = .init(width: UIScreen.main.bounds.width/2-15, height: 205)
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.register(cellType: ClubListCell.self)
        $0.showsHorizontalScrollIndicator = false
    }
    private let majorLabel = HeaderLabel(title: "내가 속한 전공 동아리")
    private let majorClubView = ClubView()
    private let freedomLabel = HeaderLabel(title: "내가 속한 자율 동아리")
    private let freedomClubView = ClubView()
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(containerView)
        containerView.addSubViews(userProfileImageView, usernameLabel, classLabel, managementButton, editorialLabel, editorialCollectionView, majorLabel, majorClubView, freedomLabel, freedomClubView)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        userProfileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(85)
            $0.top.equalToSuperview()
        }
        usernameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(userProfileImageView.snp.bottom).offset(6)
        }
        classLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(usernameLabel.snp.bottom)
        }
        managementButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(classLabel.snp.bottom).offset(15)
            $0.width.equalTo(113)
            $0.height.equalTo(30)
        }
        editorialLabel.snp.makeConstraints {
            $0.top.equalTo(managementButton.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        editorialCollectionView.snp.makeConstraints {
            $0.top.equalTo(editorialLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(210)
        }
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(editorialCollectionView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(bound.width/2-15)
        }
        majorClubView.snp.makeConstraints {
            $0.top.equalTo(majorLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalTo(bound.width/2-15)
            $0.height.equalTo(205)
        }
        freedomLabel.snp.makeConstraints {
            $0.top.equalTo(majorLabel)
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(bound.width/2-15)
        }
        freedomClubView.snp.makeConstraints {
            $0.top.equalTo(freedomLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(bound.width/2-15)
            $0.height.equalTo(205)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: MyPageReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: MyPageReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let ds = RxCollectionViewSectionedReloadDataSource<ClubListSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubListCell
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.editorialClubList)
            .map { [ClubListSection.init(header: "", items: $0)] }
            .bind(to: editorialCollectionView.rx.items(dataSource: ds))
            .disposed(by: disposeBag)
        
        majorClubView.setImage(url: "https://avatars.githubusercontent.com/u/90985750?s=100&v=4")
        majorClubView.setName(name: "Wallflower")
        freedomClubView.setImage(url: "https://avatars.githubusercontent.com/u/78971821?s=100&v=4")
        freedomClubView.setName(name: "전승원")
    }
}

