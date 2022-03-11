import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class NoticeReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case updateLoading(Bool)
    }
    enum Mutation {
        case setIsLoading(Bool)
    }
    struct State {
        var isLoading: Bool
    }
    let initialState: State
    private let id: Int
    
    // MARK: - Init
    init(
        id: Int
    ) {
        self.id = id
        initialState = State(isLoading: false)
    }
    
}

// MARK: - Mutate
extension NoticeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension NoticeReactor {
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
private extension NoticeReactor {
    
}
