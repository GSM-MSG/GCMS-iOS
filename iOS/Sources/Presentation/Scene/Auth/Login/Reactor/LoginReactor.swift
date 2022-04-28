import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class LoginReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case loginButtonDidTap
        case passwordVisibleButtonDidTap
        case updateLoading(Bool)
        case updateEmail(String)
        case updatePassword(String)
        case loginDidFailed
    }
    enum Mutation {
        case setVisiable(Bool)
        case setIsLoading(Bool)
        case setIsLoginFailure(Bool)
        case setEmail(String)
        case setPassword(String)
    }
    struct State {
        var isLoading: Bool
        var passwordVisible: Bool
        var isLoginFailure : Bool
        var password : String
        var email : String
    }
    let initialState: State
    private let loginUseCase: LoginUseCase
    
    // MARK: - Init
    init(
        loginUseCase: LoginUseCase
    ) {
        initialState = State(
            isLoading: false,
            passwordVisible: false,
            isLoginFailure: false,
            password: "",
            email: ""
        )
        self.loginUseCase = loginUseCase
    }
}

// MARK: - Mutate
extension LoginReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .loginButtonDidTap:
            return loginButtonDidTap()
        case .passwordVisibleButtonDidTap:
            return .just(.setVisiable(!currentState.passwordVisible))
        case let .updateEmail(email):
            return .just(.setEmail(email))
        case let .updatePassword(pwd):
            return .just(.setPassword(pwd))
        case .loginDidFailed:
            return .just(.setIsLoginFailure(true))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension LoginReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setVisiable(visible):
            newState.passwordVisible = visible
        case let .setIsLoading(load):
            newState.isLoading = load
        case let .setIsLoginFailure(success):
            newState.isLoginFailure = success
        case let .setEmail(email):
            newState.email = email
            newState.isLoginFailure = false
        case let .setPassword(password):
            newState.password = password
            newState.isLoginFailure = false
        }
        
        return newState
    }
}

// MARK: - Method
private extension LoginReactor {
    func loginButtonDidTap() -> Observable<Mutation> {
        
        let startLoading = Observable.just(Mutation.setIsLoading(true))
        let login = loginUseCase.execute(req: LoginRequest(email: currentState.email, password: currentState.password))
            .do(onError: { [weak self] _ in
                self?.action.onNext(.loginDidFailed)
            }, onCompleted: { [weak self] in
                self?.steps.accept(GCMSStep.clubListIsRequired)
            })
            .andThen(Single.just(Mutation.setIsLoginFailure(true)))
            .asObservable()
            .catchAndReturn(.setIsLoading(false))
            
        return .concat([startLoading, login])
    }
}
