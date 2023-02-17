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
        case appleSigninCompleted
        case appleIdTokenReceived(idToken: String, code: String)
        case signinFailed(message: String?)
        case guestSigninButtonDidTap
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
        case .appleSigninCompleted, .guestSigninButtonDidTap:
            return appleSigninCompleted()
        case let .signinFailed(message):
            return signinFailed(message: message)
        case .termsOfServiceButtonDidTap:
            UIApplication.shared.open(URL(string: "https://shy-trust-424.notion.site/f4b4084f6235444bbcc164f7c5d86fb2") ?? .init(string: "https://www.google.com")!)
        case .privacyButtonDidTap:
            UIApplication.shared.open(URL(string: "https://shy-trust-424.notion.site/252fc57341834617b7d3c1903286c730") ?? .init(string: "https://www.google.com")!)
        case let .appleIdTokenReceived(token, code):
            return appleTokenReceived(idToken: token, code: code)
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
                owner.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription, action: []))
            }
            .disposed(by: disposeBag)
        return .empty()
    }
    func appleSigninCompleted() -> Observable<Mutation> {
        UserDefaultsLocal.shared.isGuest = true
        steps.accept(GCMSStep.clubListIsRequired)
        return .empty()
    }
    func signinFailed(message: String? = "로그인을 실패하였습니다") -> Observable<Mutation> {
        self.steps.accept(GCMSStep.failureAlert(title: nil, message: message))
        return .empty()
    }
    func appleTokenReceived(idToken: String, code: String) -> Observable<Mutation> {
        return .empty()
    }
}
