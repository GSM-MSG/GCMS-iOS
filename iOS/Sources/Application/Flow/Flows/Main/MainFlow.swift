import RxFlow
import RxRelay
import RxSwift
import UIKit
import Service

struct MainStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return GCMSStep.clubListIsRequired
    }
}

final class MainFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: MainStepper = .init()
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asGCMSStep else { return .none }
        switch step{
        case .onBoardingIsRequired:
            return .end(forwardToParentFlowWithStep: GCMSStep.onBoardingIsRequired)
        case .clubListIsRequired:
            return coordinateToClubList()
        case let .clubDetailIsRequired(query):
            return navigateToDetailClub(query: query)
        case .myPageIsRequired:
            return navigateToMyPage()
        case let .alert(title, message, style, actions):
            return presentToAlert(title: title, message: message, style: style, actions: actions)
        case let .memberAppendIsRequired(closure, clubType):
            return presentToMemberAppend(closure: closure, clubType: clubType)
        case .popToRoot:
            return popToRoot()
        case .dismiss:
            return dismiss()
        // MARK: UpdateClub
        case let .firstUpdateClubIsRequired(club):
            return navigateToFirstUpdateClub(club: club)
        case let .secondUpdateClubIsRequired(reactor):
            return navigateToSecondUpdateClub(reactor: reactor)
        // MARK: NewClub
        case .firstNewClubIsRequired:
            return navigateToFirstNewClub()
        case let .secondNewClubIsRequired(reactor):
            return navigateToSecondNewClub(reactor: reactor)
        case let .thirdNewClubIsRequired(reactor):
            return navigateToThirdNewClub(reactor: reactor)
        case let .failureAlert(title, message, action):
            return presentToFailureAlert(title: title, message: message, action: action)
        case let .clubStatusIsRequired(query, isHead, isOpened):
            return navigateToClubMembers(query: query, isHead: isHead, isOpened: isOpened)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainFlow{
    func coordinateToClubList() -> FlowContributors {
        let vc = AppDelegate.container.resolve(HomeVC.self)!
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func navigateToDetailClub(query: ClubRequestQuery) -> FlowContributors {
        let reactor = AppDelegate.container.resolve(DetailClubReactor.self, argument: query)!
        let vc = DetailClubVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToFirstUpdateClub(club: Club) -> FlowContributors {
        let reactor = AppDelegate.container.resolve(UpdateClubReactor.self, argument: club)!
        let vc = FirstUpdateClubVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToSecondUpdateClub(reactor: UpdateClubReactor) -> FlowContributors {
        let vc = SecondUpdateClubVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToMyPage() -> FlowContributors {
        let vc = AppDelegate.container.resolve(MyPageVC.self)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func presentToAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction]) -> FlowContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        self.rootVC.topViewController?.present(alert, animated: true)
        return .none
    }
    func presentToMemberAppend(closure: @escaping (([User]) -> Void), clubType: ClubType) -> FlowContributors {
        let reactor = AppDelegate.container.resolve(MemberAppendReactor.self, arguments: closure, clubType)!
        let vc = MemberAppendVC(reactor: reactor)
        self.rootVC.topViewController?.presentPanModal(vc)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func dismiss() -> FlowContributors {
        self.rootVC.topViewController?.dismiss(animated: true)
        return .none
    }
    func navigateToFirstNewClub() -> FlowContributors {
        let vc = AppDelegate.container.resolve(FirstNewClubVC.self)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func navigateToSecondNewClub(reactor: NewClubReactor?) -> FlowContributors {
        let vc = AppDelegate.container.resolve(SecondNewClubVC.self, argument: reactor)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func navigateToThirdNewClub(reactor: NewClubReactor?) -> FlowContributors {
        let vc = AppDelegate.container.resolve(ThirdNewClubVC.self, argument: reactor)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func presentToFailureAlert(title: String?, message: String?, action: [UIAlertAction] = []) -> FlowContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !action.isEmpty{
            action.forEach(alert.addAction(_:))
        } else {
            alert.addAction(.init(title: "확인", style: .default))
        }
        self.rootVC.topViewController?.present(alert, animated: true)
        return .none
    }
    func navigateToClubMembers(query: ClubRequestQuery, isHead: Bool, isOpened: Bool) -> FlowContributors {
        let reactor = AppDelegate.container.resolve(ClubMemberReactor.self, arguments: query, isOpened)!
        let vc = ClubMemberVC(reactor: reactor, isHead: isHead)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func popToRoot() -> FlowContributors {
        self.rootVC.popToRootViewController(animated: true)
        return .none
    }
}
