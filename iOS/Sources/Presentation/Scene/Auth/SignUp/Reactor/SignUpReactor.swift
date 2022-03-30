import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class SignUpReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case updateLoading(Bool)
        case certificationButtonDidTap
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
    ) {
        initialState = State(isLoading: false)
    }
    
}

// MARK: - Mutate
extension SignUpReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .certificationButtonDidTap:
            steps.accept(GCMSStep.certificationIsRequired)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension SignUpReactor {
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
private extension SignUpReactor {
    
}
