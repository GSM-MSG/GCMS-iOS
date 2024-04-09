import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class ClubAttendReactor: Reactor, Stepper {
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
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
    
    init(
    ) {
        initialState = State(isLoading: false)
    }
}

extension ClubAttendReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        }
        return .empty()
    }
}

extension ClubAttendReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setIsLoading(load):
            newState.isLoading = load
        }
        
        return newState
    }
}
