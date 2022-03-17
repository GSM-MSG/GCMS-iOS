import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import GoogleSignIn
import FirebaseCore
import AuthenticationServices
import Service

final class OnBoardingReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    private let loginUseCase: LoginUseCase
    
    // MARK: - Reactor
    enum Action {
        case googleSigninButtonDidTap(UIViewController)
        case googleSigninTokenReceived(String)
        case updateLoading(Bool)
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
            steps.accept(GCMSStep.clubListIsRequired)
            return .empty()
            return googleSigninButtonDidTap(vc: vc)
        case let .googleSigninTokenReceived(token):
            return googleSigninTokenReceived(token: token)
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        }
    }
}

// MARK: - Reduce
extension OnBoardingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setIsLoading(load):
            newState.isLoading = load
        }
        return newState
    }
}

// MARK: - Method
private extension OnBoardingReactor {
    func googleSigninButtonDidTap(vc: UIViewController) -> Observable<Mutation> {
        let config = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) {[weak self] user, err in
            if let err = err {
                print(err.localizedDescription)
                print("Goolge Signin Failure")
                return
            }
            
            user?.authentication.do({ auth in
                UserDefaultsLocal.shared.isApple = false
                self?.action.onNext(.googleSigninTokenReceived(auth.idToken ?? ""))
            })
        }
        return .empty()
    }
    func googleSigninTokenReceived(token: String) -> Observable<Mutation> {
        steps.accept(GCMSStep.clubListIsRequired)
        return .empty()
    }
}
