import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import GoogleSignIn
import FirebaseCore
import Service

final class OnBoardingReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    private let loginUseCase: LoginUseCase
    
    // MARK: - Reactor
    enum Action {
        case googleSigninButtonDidTap(UIViewController)
        case googleSigninCompleted
        case appleSigninCompleted
        case appleSigninFailed
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
        case let .googleSigninButtonDidTap(vc):
            return googleSigninButtonDidTap(vc: vc)
        case .appleSigninCompleted:
            return appleSigninCompleted()
        case .appleSigninFailed:
            return signinFailed()
        case .googleSigninCompleted:
            return googleSigninCompleted()
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
    func googleSigninButtonDidTap(vc: UIViewController) -> Observable<Mutation> {
        let config = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [weak self] user, err in
            if let err = err {
                print(err.localizedDescription)
                self.action.onNext(.appleSigninFailed)
                return
            }
            
            user?.authentication.do({ auth in
                if let idToken = auth.idToken {
                    print(idToken)
                    self?.googleSigninTokenReceived(token: idToken)
                }
            })
        }
        return .empty()
    }
    func googleSigninTokenReceived(token: String) {
        UserDefaultsLocal.shared.isApple = false
        loginUseCase.execute(idToken: token)
            .andThen(.just(()))
            .map { Action.googleSigninCompleted }
            .catchAndReturn(.appleSigninFailed)
            .bind(to: action)
            .disposed(by: disposeBag)
    }
    func googleSigninCompleted() -> Observable<Mutation> {
        steps.accept(GCMSStep.clubListIsRequired)
        return .empty()
    }
    func appleSigninCompleted() -> Observable<Mutation> {
        UserDefaultsLocal.shared.isApple = true
        steps.accept(GCMSStep.clubListIsRequired)
        return .empty()
    }
    func signinFailed(message: String = "로그인이 실패하였습니다") -> Observable<Mutation> {
        self.steps.accept(GCMSStep.failureAlert(title: nil, message: "로그인이 실패하였습니다", action: nil))
        return .empty()
    }
}
