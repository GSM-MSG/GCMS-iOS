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

final class HomeVC: TabmanViewController, View {
    // MARK: - Properties
    private var viewControllers: [UIViewController] = []
    private let myPageButton = UIBarButtonItem(image: .init(systemName: "person.circle")?.tintColor(GCMSAsset.Colors.gcmsGray4.color),
                                               style: .plain,
                                               target: nil,
                                               action: nil)
    private let newClubButton = UIBarButtonItem(image: .init(systemName: "plus.app")?.tintColor(GCMSAsset.Colors.gcmsGray4.color),
                                              style: .plain,
                                              target: nil,
                                              action: nil)
    private lazy var indicator = AnimationView(name: "GCMS-Indicator").then {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
        $0.stop()
        $0.isHidden = true
    }
    private let indicatorBackgroundView = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = .black.withAlphaComponent(0.4)
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
        bar.layout.interButtonSpacing = 20
        bar.buttons.customize {
            $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13) ?? .init()
            $0.tintColor = GCMSAsset.Colors.gcmsGray3.color
            $0.selectedFont = UIFont(font: GCMSFontFamily.Inter.bold, size: 13) ?? .init()
            $0.selectedTintColor = UIColor(red: 0, green: 0.65, blue: 1, alpha: 0.99)
        }
        bar.layout.contentMode = .fit
        bar.indicator.weight = .custom(value: 0)
        bar.layout.alignment = .centerDistributed
        bar.systemBar().backgroundStyle = .clear
        addBar(bar, dataSource: self, at: .navigationItem(item: self.navigationItem))
    }
    
    // MARK: - UI
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        configNavigation()
    }
    
    func bind(reactor: HomeReactor) {
        bindView(reactor: reactor)
        bindState(reactor: reactor)
    }
}

// MARK: - Extension
private extension HomeVC {
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
    func configNavigation(){
        self.navigationItem.setLeftBarButton(myPageButton, animated: true)
        self.navigationItem.setRightBarButton(newClubButton, animated: true)
        self.navigationItem.configBack()
    }
    func bindView(reactor: HomeReactor) {
        myPageButton.rx.tap
            .map { _ in Reactor.Action.myPageButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        newClubButton.rx.tap
            .map { _ in Reactor.Action.newClubButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    func bindState(reactor: HomeReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
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
        var title = ""
        switch index {
        case 0: title = "전공"
        case 1: title = "자율"
        case 2: title = "사설"
        default: title = "Anomaly"
        }
        return TMBarItem(title: title)
    }
}
