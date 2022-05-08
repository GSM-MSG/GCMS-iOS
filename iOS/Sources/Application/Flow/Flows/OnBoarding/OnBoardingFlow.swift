import RxFlow
import RxRelay
import RxSwift
import UIKit
import Service
import Loaf

struct OnBoardingStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return GCMSStep.onBoardingIsRequired
    }
}

final class OnBoardingFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: OnBoardingStepper = .init()
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
            return coordinateToOnBoarding()
        case .clubListIsRequired:
            return .end(forwardToParentFlowWithStep: GCMSStep.clubListIsRequired)
        case .dismiss:
            return dismissVC()
        case let .loaf(message, state: state, location: location):
            return showLoaf(message, state: state, location: location)
        case let .alert(title, message, style, actions):
            return presentToAlert(title: title, message: message, style: style, actions: actions)
        case let .failureAlert(title, message, action):
            return presentToFailureAlert(title: title, message: message, action: action)
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension OnBoardingFlow{
    func coordinateToOnBoarding() -> FlowContributors {
        let vc = AppDelegate.container.resolve(OnBoardingVC.self)!
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func dismissVC() -> FlowContributors {
        self.rootVC.visibleViewController?.dismiss(animated: true)
        return .none
    }

    func showLoaf(
        _ message: String,
        state: Loaf.State,
        location: Loaf.Location
    ) -> FlowContributors {
        Loaf(message, state: state, location: location, sender: self.rootVC.visibleViewController ?? .init()).show()
        return .none
    }
    func presentToAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction]) -> FlowContributors {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        self.rootVC.visibleViewController?.present(alert, animated: true)
        return .none
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
}
