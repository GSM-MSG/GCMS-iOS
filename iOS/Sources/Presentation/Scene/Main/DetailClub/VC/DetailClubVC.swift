import UIKit
import BTImageView
import Reusable
import PinLayout
import RxSwift
import RxDataSources

final class DetailClubVC: BaseVC<DetailClubReactor> {
    // MARK: - Metric
    enum Metric {
        static let sectionSpace: CGFloat = 40
        static let headerContentSpace: CGFloat = 10
        static let horizontalMargin: CGFloat = 16
    }
    // MARK: - Properties
    private let contentView = UIScrollView()
    private let containerView = UIView().then {
        $0.layer.cornerRadius = 25
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    private let bannerImageView = UIImageView().then {
        $0.backgroundColor = .white
    }
    private let descriptionHeaderLabel = HeaderLabel(title: "동아리 설명")
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
    }
    private let activityHeaderLabel = HeaderLabel(title: "동아리 활동")
    private let activityView = BTImageView(aligns: [2,2], axis: .horizontal).then {
        $0.spacing = 15
        $0.cornerRadius = 10
    }
    private let memberHeaderLabel = HeaderLabel(title: "구성원")
    private let memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 61, height: 82)
        $0.collectionViewLayout = layout
        $0.register(cellType: MemberCell.self)
        $0.backgroundColor = .clear
    }
    private let headHeaderLabel = HeaderLabel(title: "부장")
    private let headView = UserHorizontalView()
    private let teacherHeaderLabel = HeaderLabel(title: "선생님")
    private let teacherView = UserHorizontalView()
    private let contactHeaderLabel = HeaderLabel(title: "연락처")
    private let contactDescriptionLabel = UILabel().then { 
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 12)
    }
    private let applyButton = UIButton().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.titleLabel?.textAlignment = .center
        $0.setTitle("신청하기", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(contentView, applyButton)
        contentView.addSubViews(bannerImageView, containerView)
        containerView.addSubViews(descriptionHeaderLabel, descriptionLabel, activityHeaderLabel, activityView, memberHeaderLabel, memberCollectionView, headHeaderLabel, headView, teacherHeaderLabel, teacherView, contactHeaderLabel, contactDescriptionLabel)
    }
    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        bannerImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(bound.width*0.5924)
            $0.width.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        applyButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        descriptionHeaderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.leading.trailing.equalTo(descriptionHeaderLabel)
        }
        activityHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Metric.sectionSpace)
            $0.leading.trailing.equalTo(descriptionLabel)
        }
        activityView.snp.makeConstraints {
            $0.top.equalTo(activityHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(bound.width-32)
        }
        memberHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(activityView.snp.bottom).offset(Metric.sectionSpace)
            $0.leading.trailing.equalTo(activityView)
        }
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(memberHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.leading.trailing.equalTo(memberHeaderLabel)
            $0.height.equalTo(82)
        }
        headHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(Metric.sectionSpace)
            $0.leading.trailing.equalTo(memberCollectionView)
        }
        headView.snp.makeConstraints {
            $0.top.equalTo(headHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.leading.equalTo(headHeaderLabel)
            $0.trailing.equalTo(view.snp.centerX)
            $0.height.equalTo(61)
        }
        teacherHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(Metric.sectionSpace)
            $0.leading.equalTo(view.snp.centerX)
            $0.trailing.equalToSuperview().inset(Metric.horizontalMargin)
        }
        teacherView.snp.makeConstraints {
            $0.top.equalTo(teacherHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.leading.trailing.equalTo(teacherHeaderLabel)
            $0.height.equalTo(61)
            $0.width.equalTo(bound.width/2)
        }
        contactHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(headView.snp.bottom).offset(Metric.sectionSpace)
            $0.leading.trailing.equalTo(memberCollectionView)
        }
        contactDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(contactHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.leading.trailing.equalTo(contactHeaderLabel)
            $0.bottom.equalToSuperview().offset(-80)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationController?.navigationBar.setClear()
    }
    
    // MARK: - Reactor
    override func bindAction(reactor: DetailClubReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: DetailClubReactor) {
        let sharedState = reactor.state.share(replay: 2).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.clubDetail)
            .compactMap { $0 }
            .withUnretained(self)
            .bind { owner, item in
                owner.descriptionLabel.text = item.description
//                owner.activityView.setImages(urls: item.activities)
                if item.activities.isEmpty {
                    owner.activityView.snp.updateConstraints {
                        $0.height.equalTo(0)
                    }
                }
                owner.activityView.setImages(images: [
                    .init(systemName: "1.circle") ?? .init(),
                    .init(systemName: "2.circle") ?? .init(),
                    .init(systemName: "3.circle") ?? .init(),
                    .init(systemName: "4.circle") ?? .init()
                ])
                owner.headView.bind(user: item.head)
                if let teacher = item.teacher {
                    owner.teacherHeaderLabel.isHidden = false
                    owner.teacherView.isHidden = false
                    owner.teacherView.bind(user: teacher)
                } else {
                    owner.teacherHeaderLabel.isHidden = true
                    owner.teacherView.isHidden = true
                }
                owner.contactDescriptionLabel.text = item.contact
                owner.navigationItem.configTitle(title: item.name)
            }
            .disposed(by: disposeBag)
        
        let ds = RxCollectionViewSectionedReloadDataSource<MemberSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as MemberCell
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.clubDetail?.members)
            .compactMap { $0 }
            .map { [MemberSection(header: "", items: $0)] }
            .bind(to: memberCollectionView.rx.items(dataSource: ds))
            .disposed(by: disposeBag)
            
    }
}
