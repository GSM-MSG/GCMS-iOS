import ReactorKit
import UIKit
import RxFlow
import RxSwift
import RxRelay
import FirebaseCore
import Service

final class OnBoardingReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()

    private let disposeBag: DisposeBag = .init()

    private let loginUseCase: LoginUseCase

    // MARK: - Reactor
    enum Action {
        case gauthSigninCompleted(code: String)
        case signinFailed(message: String?)
        case termsOfServiceButtonDidTap
        case privacyButtonDidTap
    }
    enum Mutation {
        case setIsLoading(Bool)
    }
    struct State {
        var isLoading: Bool
    }
    let initialState: State

    // MARK: - Init
    init(
        loginUseCase: LoginUseCase
    ) {
        initialState = State(
            isLoading: false
        )
        self.loginUseCase = loginUseCase
    }

}

// MARK: - Mutate
extension OnBoardingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .gauthSigninCompleted(code):
            return gauthSigninCompleted(code: code)
        case let .signinFailed(message):
            return signinFailed(message: message)
        case .termsOfServiceButtonDidTap:
            UIApplication.shared.open(URL(string: "https://matsogeum.notion.site/0f7c494b26114da098d0c8ea50bb5588") ?? .init(string: "https://www.google.com")!)
        case .privacyButtonDidTap:
            UIApplication.shared.open(URL(string: "https://matsogeum.notion.site/db8c0669605e4685b036cc08293aceb7") ?? .init(string: "https://www.google.com")!)
        }
        return .empty()
    }
}

extension OnBoardingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setIsLoading(loading):
            newState.isLoading = loading
        }
        return newState
    }
}

// MARK: - Method
private extension OnBoardingReactor {
    func gauthSigninCompleted(code: String) -> Observable<Mutation> {
        loginUseCase.execute(code: code)
            .andThen(Observable.just(()))
            .subscribe(with: self) { owner, _ in
                owner.steps.accept(GCMSStep.clubListIsRequired)
            } onError: { owner, e in
                owner.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.localizedDescription, action: []))
            }
            .disposed(by: disposeBag)
        return .empty()
    }
    func signinFailed(message: String? = "로그인을 실패하였습니다") -> Observable<Mutation> {
        self.steps.accept(GCMSStep.failureAlert(title: nil, message: message))
        return .empty()
    }
}
