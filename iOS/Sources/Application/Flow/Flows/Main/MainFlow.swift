import RxFlow
import RxRelay
import RxSwift
import UIKit

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
    private let rootVC = UINavigationController().then {
        $0.isHeroEnabled = true
    }
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asGCMSStep else { return .none }
        switch step{
        case .clubListIsRequired:
            return coordinateToClubList()
        case let .clubDetailIsRequired(id):
            return navigateToDetailClub(id: id)
        case .myPageIsRequired:
            return navigateToMyPage()
        case .alarmListIsRequired:
            return navigateToAlarm()
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
    func navigateToDetailClub(id: Int) -> FlowContributors {
        let reactor = DetailClubReactor(id: id)
        let vc = DetailClubVC(reactor: reactor)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func navigateToMyPage() -> FlowContributors {
        let vc = AppDelegate.container.resolve(MyPageVC.self)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func navigateToAlarm() -> FlowContributors {
        let vc = AppDelegate.container.resolve(NewClubVC.self)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
}
