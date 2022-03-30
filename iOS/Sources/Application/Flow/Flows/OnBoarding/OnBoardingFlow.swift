import RxFlow
import RxRelay
import RxSwift
import UIKit

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
        case .loginIsRequired:
            return navigateToLogin()
        case .clubListIsRequired:
            return .end(forwardToParentFlowWithStep: GCMSStep.clubListIsRequired)
        case .certificationIsRequired:
            return navigateCertification()
        case .signUpIsRequired:
            return navigateToSignUp()
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
    func navigateToLogin() -> FlowContributors {
        let vc = AppDelegate.container.resolve(LoginVC.self)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func navigateCertification() -> FlowContributors {
        let vc = AppDelegate.container.resolve(CertificationVC.self)!
        self.rootVC.present(UINavigationController(rootViewController: vc), animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
    func navigateToSignUp() -> FlowContributors {
        let vc = AppDelegate.container.resolve(SignUpVC.self)!
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: vc.reactor!))
    }
}
