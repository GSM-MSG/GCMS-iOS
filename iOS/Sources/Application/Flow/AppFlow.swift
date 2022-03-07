//
//  AppFlow.swift
//
//
//  Created by baegteun on 2021/11/30.
//

import RxFlow
import RxRelay
import RxSwift
import UIKit

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let disposeBag: DisposeBag = .init()
    
    func readyToEmitSteps() {
        steps.accept(GCMSStep.onBoardingIsRequired)
    }
}

final class AppFlow: Flow{
    
    // MARK: - Properties
    var root: Presentable{
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    
    // MARK: - Init
    
    init(
        with window: UIWindow
    ){
        self.rootWindow = window
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asGCMSStep else { return .none }
        
        switch step{
        case .onBoardingIsRequired:
            return coordinateToOnBoarding()
        case .clubListIsRequired:
            return coordinateToClubList()
        default:
            return .none
        }
    }
}

// MARK: - Method

private extension AppFlow{
    func coordinateToOnBoarding() -> FlowContributors {
        let flow = OnBoardingFlow()
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: flow.stepper))
    }
    func coordinateToClubList() -> FlowContributors {
        let flow = MainFlow()
        Flows.use(
            flow,
            when: .created
        ) { [unowned self] root in
            self.rootWindow.rootViewController = root
        }
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: flow.stepper))
    }
}
