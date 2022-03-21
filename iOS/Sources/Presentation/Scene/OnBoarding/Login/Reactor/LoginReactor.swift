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
    }
    enum Mutation {
        case setIsLoading(Bool)
    }
    struct State {
        var isLoading: Bool
        var passwordVisible: Bool
    }
    let initialState: State
    
    // MARK: - Init
    init(
    ) {
        initialState = State(isLoading: false, passwordVisible: false)
    }
    
}

// MARK: - Mutate
extension LoginReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .loginButtonDidTap:
            steps.accept(GCMSStep.clubListIsRequired)
        case .passwordVisibleButtonDidTap:
            return passwordVisibleButtonDidTap()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension LoginReactor {
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
private extension LoginReactor {
    func passwordVisibleButtonDidTap() -> Observable<Mutation> {
        return .empty()
    }
}
