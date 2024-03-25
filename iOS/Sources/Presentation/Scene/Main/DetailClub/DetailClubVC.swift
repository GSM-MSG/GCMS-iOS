import UIKit
import BTImageView
import Reusable
import RxSwift
import RxDataSources
import Kingfisher
import Service
import SnapKit
import Configure

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
        $0.backgroundColor = GCMSAsset.Colors.gcmsGray3.color
        $0.contentMode = .scaleAspectFill
    }
    private let shadowView = UIView()
    private let descriptionHeaderLabel = HeaderLabel(title: "동아리 설명")
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = GCMSAsset.Colors.gcmsGray1.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
    }
    private let notionLinkHeaderLabel = HeaderLabel(title: "노션 링크")
    private let notionLinkButton = UIButton().then {
        $0.setTitleColor(.init(red: 0.18, green: 0.36, blue: 1, alpha: 1), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 13)
        $0.titleLabel?.textAlignment = .left
    }
    private let activityHeaderLabel = HeaderLabel(title: "동아리 활동")
    private let activityView = BTImageView(aligns: [2, 2], axis: .horizontal).then {
        $0.spacing = 15
        $0.layer.cornerRadius = 10
    }
    private let memberHeaderLabel = HeaderLabel(title: "구성원")
    private let memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 61, height: 82)
        $0.collectionViewLayout = layout
        $0.register(cellType: ClubMemberCell.self)
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
    private lazy var statusButton = UIBarButtonItem(image: .init(systemName: "gearshape")?.tintColor(.white), style: .plain, target: nil, action: nil)

    // MARK: - UI
    override func addView() {
        view.addSubViews(contentView, applyButton, shadowView)
        contentView.addSubViews(bannerImageView, containerView)
        containerView.addSubViews(descriptionHeaderLabel, descriptionLabel, notionLinkHeaderLabel, notionLinkButton, activityHeaderLabel, activityView, memberHeaderLabel, memberCollectionView, headHeaderLabel, headView, teacherHeaderLabel, teacherView, contactHeaderLabel, contactDescriptionLabel)
    }
    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        bannerImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bound.width*0.5924)
            $0.width.equalToSuperview()
        }
        shadowView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-72)
            $0.height.equalTo(bound.width*0.5924)
            $0.width.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        applyButton.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.safeAreaInsets.bottom + 72)
        }
        descriptionHeaderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.leading.trailing.equalTo(descriptionHeaderLabel)
        }
        notionLinkHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Metric.sectionSpace)
            $0.leading.trailing.equalTo(descriptionLabel)
        }
        notionLinkButton.snp.makeConstraints {
            $0.top.equalTo(notionLinkHeaderLabel.snp.bottom).offset(Metric.headerContentSpace)
            $0.leading.trailing.equalTo(notionLinkHeaderLabel)
        }
        activityHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(notionLinkButton.snp.bottom).offset(Metric.sectionSpace)
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
        self.navigationItem.configBack()
    }

    // MARK: - Reactor
    override func bindView(reactor: DetailClubReactor) {
        statusButton.rx.tap
            .map { Reactor.Action.statusButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        notionLinkButton.rx.tap
            .map { Reactor.Action.linkButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        applyButton.rx.tap
            .map { Reactor.Action.bottomButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindAction(reactor: DetailClubReactor) {
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: DetailClubReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)

        sharedState
            .compactMap(\.clubDetail)
            .bind(with: self) { owner, item in
                owner.bannerImageView.kf.setImage(
                    with: URL(string: item.bannerImg)
                )
                owner.shadowView.addGradientWithColor(color: .black)
                owner.descriptionLabel.text = item.content
                owner.activityView.setImages(urls: item.activityImgs)
                owner.notionLinkButton.setTitle(item.notionLink, for: .normal)
                owner.notionLinkButton.isHidden = false
                if item.activityImgs.isEmpty {
                    owner.activityView.snp.updateConstraints {
                        $0.height.equalTo(0)
                    }
                } else {
                    owner.activityView.snp.updateConstraints {
                        $0.height.equalTo(owner.bound.width-32)
                    }
                }
                owner.loadViewIfNeeded()
                switch item.scope {
                case .head:
                    owner.applyButton.setTitle(item.isOpen ? "동아리 신청 마감하기" : "동아리 신청 받기", for: .normal)
                    owner.navigationItem.setRightBarButton(owner.statusButton, animated: true)
                case .member:
                    owner.applyButton.isHidden = true
                    owner.navigationItem.setRightBarButton(owner.statusButton, animated: true)
                case .`default`:
                    if item.isOpen {
                        owner.applyButton.setTitle(item.isApplied ? "신청취소하기" : "동아리 신청하기", for: .normal)
                        owner.applyButton.backgroundColor = item.isApplied
                        ? GCMSAsset.Colors.gcmsThemeColor.color
                        : GCMSAsset.Colors.gcmsMainColor.color
                    } else {
                        owner.setClosedButton()
                    }
                case .other:
                    owner.applyButton.isHidden = true
                }
                owner.headView.bind(user: item.head)
                if let teacher = item.teacher, !teacher.isEmpty {
                    owner.teacherHeaderLabel.isHidden = false
                    owner.teacherView.isHidden = false
                    owner.teacherView.setName(name: teacher)
                } else {
                    owner.teacherHeaderLabel.isHidden = true
                    owner.teacherView.isHidden = true
                }
                owner.contactDescriptionLabel.text = item.contact
                owner.navigationItem.configTitle(title: item.name)
            }
            .disposed(by: disposeBag)

        let ds = RxCollectionViewSectionedReloadDataSource<ClubMemberSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip) as ClubMemberCell
            cell.model = item
            return cell
        }

        sharedState
            .map(\.clubDetail)
            .compactMap(\.?.member)
            .map { [ClubMemberSection(header: "", items: $0)] }
            .bind(to: memberCollectionView.rx.items(dataSource: ds))
            .disposed(by: disposeBag)

        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}

private extension DetailClubVC {
    func setClosedButton() {
        applyButton.setTitle("마감됨", for: .normal)
        applyButton.backgroundColor = .init(red: 0.58, green: 0.58, blue: 0.58, alpha: 1)
    }
}
