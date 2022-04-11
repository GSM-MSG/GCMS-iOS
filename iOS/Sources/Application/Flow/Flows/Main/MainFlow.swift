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
        case .popToRoot:
            return popToRoot()
        case let .clubDetailIsRequired(query):
            return navigateToDetailClub(query: query)
        case .myPageIsRequired:
            return navigateToMyPage()
        case let .alert(title, message, style, actions):
            return presentToAlert(title: title, message: message, style: style, actions: actions)
        case let .memberAppendIsRequired(closure):
            return presentToMemberAppend(closure: closure)
        case .dismiss:
            return dismiss()
        case .firstNewClubIsRequired:
            return navigateToFirstNewClub()
        case let .secondNewClubIsRequired(reactor):
            return navigateToSecondNewClub(reactor: reactor)
        case let .thirdNewClubIsRequired(reactor):
            return navigateToThirdNewClub(reactor: reactor)
        case let .failureAlert(title, message, action):
            return presentToFailureAlert(title: title, message: message, action: action)
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
        let reactor = DetailClubReactor()
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
        self.rootVC.visibleViewController?.present(alert, animated: true)
        return .none
    }
    func presentToMemberAppend(closure: @escaping (([User]) -> Void)) -> FlowContributors {
        let reactor = MemberAppendReactor(
            closure: closure
        )
        let vc = MemberAppendVC(reactor: reactor)
        self.rootVC.visibleViewController?.presentPanModal(vc)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func dismiss() -> FlowContributors {
        self.rootVC.visibleViewController?.dismiss(animated: true)
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
    func presentToFailureAlert(title: String?, message: String?, action: UIAlertAction?) -> FlowContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let action = action {
            alert.addAction(action)
        } else {
            alert.addAction(.init(title: "확인", style: .default))
        }
        self.rootVC.visibleViewController?.present(alert, animated: true)
        return .none
    }
    func popToRoot() -> FlowContributors {
        self.rootVC.popToRootViewController(animated: true)
        return .none
    }
}
