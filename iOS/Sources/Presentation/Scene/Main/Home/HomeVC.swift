import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources
import Reusable
import Service
import Tabman
import ReactorKit
import Pageboy
import Lottie
import Kingfisher

final class HomeVC: TabmanViewController, View {
    // MARK: - Properties
    private var viewControllers: [UIViewController] = []
    private let profileImageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 25, height: 25)).then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 12.5
        $0.layer.masksToBounds = true
    }
    private let profileButton = UIButton()
    private let myPageButton = UIBarButtonItem(image: .init(systemName: "person.crop.circle")?.tintColor(GCMSAsset.Colors.gcmsGray4.color),
                                         style: .plain,
                                         target: nil,
                                         action: nil)
    private lazy var indicator = LottieAnimationView(name: "GCMS-Indicator").then {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
        $0.stop()
        $0.isHidden = true
    }
    private let indicatorBackgroundView = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = .black.withAlphaComponent(0.4)
    }
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 28, weight: .black)
    }
    var disposeBag: DisposeBag = .init()

    typealias Reactor = HomeReactor

    init(reactor: HomeReactor?) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method
    public func setViewControllers(_ vcs: [UIViewController]) {
        self.viewControllers = vcs
        self.dataSource = self

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.interButtonSpacing = 90
        bar.buttons.customize {
            $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 15) ?? .init()
            $0.tintColor = GCMSAsset.Colors.gcmsGray3.color
            $0.selectedFont = UIFont(font: GCMSFontFamily.Inter.bold, size: 15) ?? .init()
            $0.selectedTintColor = UIColor(red: 0, green: 0.65, blue: 1, alpha: 0.99)
        }
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.cornerStyle = .rounded
        bar.layout.alignment = .centerDistributed
        bar.systemBar().backgroundStyle = .clear
        addBar(bar, dataSource: self, at: .bottom)
    }

    // MARK: - UI
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addView()
        setLayout()
        configNavigation()
        bounces = false
    }
    func bind(reactor: HomeReactor) {
        bindAction(reactor: reactor)
        bindView(reactor: reactor)
        bindState(reactor: reactor)
    }
}

// MARK: - Extension
private extension HomeVC {
    func setup() {
        profileButton.addSubview(profileImageView)
        myPageButton.customView = profileButton
    }
    func addView() {
        view.addSubViews(indicatorBackgroundView, indicator)
    }
    func setLayout() {
        indicatorBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(150)
        }
    }
    func configNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        self.navigationItem.rightBarButtonItem = myPageButton
        self.navigationItem.configBack()
    }
    func bindAction(reactor: HomeReactor) {
        self.rx.viewDidLoad
            .map { Reactor.Action.viewDidLoad }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    func bindView(reactor: HomeReactor) {
        profileButton.rx.tap
            .map { _ in Reactor.Action.myPageButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    func bindState(reactor: HomeReactor) {
        let sharedState = reactor.state.share(replay: 3).observe(on: MainScheduler.asyncInstance)

        sharedState
            .map(\.clubType)
            .map { "\($0.display)동아리" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)

        sharedState
            .map(\.profileImageURL)
            .bind(with: self) { owner, profile in
                if !profile.isEmpty {
                    owner.profileImageView.kf.setImage(with: URL(string: profile) ?? .none,
                                                placeholder: UIImage())
                } else {
                    owner.profileImageView.image = .init(systemName: "person.crop.circle")?.tintColor(GCMSAsset.Colors.gcmsGray4.color)
                }
            }
            .disposed(by: disposeBag)
    }
    func startIndicator() {
        indicatorBackgroundView.isHidden = false
        indicator.isHidden = false
        indicator.play()
    }
    func stopIndicator() {
        indicatorBackgroundView.isHidden = true
        indicator.isHidden = true
        indicator.stop()
    }
}

extension HomeVC: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let clubCase = ClubType.allCases

        return TMBarItem(title: clubCase[index].display)
    }
}
