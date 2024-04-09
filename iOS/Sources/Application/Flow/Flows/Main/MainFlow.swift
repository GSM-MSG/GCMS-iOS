import RxFlow
import RxRelay
import RxSwift
import UIKit
import Service

struct MainStepper: Stepper {
    let steps: PublishRelay<Step> = .init()

    var initialStep: Step {
        return GCMSStep.clubListIsRequired
    }
}

final class MainFlow: Flow {
    // MARK: - Properties
    var root: Presentable {
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
        switch step {
        case .onBoardingIsRequired:
            return .end(forwardToParentFlowWithStep: GCMSStep.onBoardingIsRequired)
        case .clubListIsRequired:
            return coordinateToClubList()
        case let .clubDetailIsRequired(clubID):
            return navigateToDetailClub(clubID: clubID)
        case .myPageIsRequired:
            return navigateToMyPage()
        case let .alert(title, message, style, actions):
            return presentToAlert(title: title, message: message, style: style, actions: actions)
        case .popToRoot:
            return popToRoot()
        case .dismiss:
            return dismiss()
        // MARK: UpdateClub
        case let .failureAlert(title, message, action):
            return presentToFailureAlert(title: title, message: message, action: action)
        case let .clubStatusIsRequired(clubID, isHead, isOpened):
            return navigateToClubMembers(clubID: clubID, isHead: isHead, isOpened: isOpened)
        case .clubAttendIsRequired:
            return navigateToClubAttendPage()
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainFlow {
    func coordinateToClubList() -> FlowContributors {
        let vc = AppDelegate.container.resolve(HomeVC.self)!
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func navigateToDetailClub(clubID: Int) -> FlowContributors {
        let reactor = AppDelegate.container.resolve(DetailClubReactor.self, argument: clubID)!
        let vc = DetailClubVC(reactor: reactor)
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
    func dismiss() -> FlowContributors {
        self.rootVC.topViewController?.dismiss(animated: true)
        return .none
    }
    func presentToFailureAlert(title: String?, message: String?, action: [UIAlertAction] = []) -> FlowContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !action.isEmpty {
            action.forEach(alert.addAction(_:))
        } else {
            alert.addAction(.init(title: "확인", style: .default))
        }
        self.rootVC.topViewController?.present(alert, animated: true)
        return .none
    }
    func navigateToClubMembers(clubID: Int, isHead: Bool, isOpened: Bool) -> FlowContributors {
        let reactor = AppDelegate.container.resolve(ClubMemberReactor.self, arguments: clubID, isOpened)!
        let vc = ClubMemberVC(reactor: reactor, isHead: isHead)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToClubAttendPage() -> FlowContributors {
        let reactor = AppDelegate.container.resolve(ClubAttendReactor.self)!
        let vc = ClubAttendVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func popToRoot() -> FlowContributors {
        self.rootVC.popToRootViewController(animated: true)
        return .none
    }
}
