import ReactorKit
import RxFlow
import RxSwift
import RxRelay
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
        case loginButtonDidTap
        case signUpButtonDidTap
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
        case .loginButtonDidTap:
            steps.accept(GCMSStep.loginIsRequired)
        case .signUpButtonDidTap:
            steps.accept(GCMSStep.signUpIsRequired)
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        }
    return .empty()
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
 
}
