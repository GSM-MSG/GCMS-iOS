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
    
    private let stepper: MainStepper = .init()
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asGCMSStep else { return .none }
        switch step{
            
        default:
            return .none
        }
    }
}

// MARK: - Method
private extension MainFlow{
    
}
