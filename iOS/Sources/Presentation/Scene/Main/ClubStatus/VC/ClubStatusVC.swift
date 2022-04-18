import UIKit
import Reusable
import SnapKit
import Tabman
import ReactorKit
import Pageboy

final class ClubStatusVC: TabmanViewController, View {
    // MARK: - Properties
    private var viewControllers: [UIViewController] = []
    private let tabView = UIView()
    
    var disposeBag: DisposeBag = .init()
    
    typealias Reactor = ClubStatusReactor
    
    init(reactor: ClubStatusReactor?) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(tabView)
        tabView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Method
    public func setViewControllers(_ vcs: [UIViewController]) {
        self.viewControllers = vcs
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.indicator.tintColor = GCMSAsset.Colors.gcmsGray1.color
        bar.systemBar().backgroundStyle = .clear
        bar.buttons.customize { button in
            button.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 17) ?? .init()
            button.selectedFont = UIFont(font: GCMSFontFamily.Inter.bold, size: 17) ?? .init()
            button.tintColor = GCMSAsset.Colors.gcmsGray4.color
            button.selectedTintColor = GCMSAsset.Colors.gcmsGray1.color
        }
        bar.layout.contentMode = .fit
        bar.indicator.weight = .custom(value: 1)
        addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil))
    }
    
    // MARK: - Reactor
    func bind(reactor: ClubStatusReactor) {
        bindView(reactor: reactor)
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension ClubStatusVC: PageboyViewControllerDataSource, TMBarDataSource {
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
        case 0:
            title = "신청자"
        case 1:
            title = "멤버"
        default:
            title = "Anomaly"
        }
        return TMBarItem(title: title)
    }
    
    
}

private extension ClubStatusVC {
    func bindView(reactor: ClubStatusReactor) {
        
    }
    func bindState(reactor: ClubStatusReactor) {
        
    }
    func bindAction(reactor: ClubStatusReactor) {
        
    }
}
