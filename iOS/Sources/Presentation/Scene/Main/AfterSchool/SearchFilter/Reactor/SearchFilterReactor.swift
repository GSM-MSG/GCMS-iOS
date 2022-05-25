import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import Foundation

class SearchFilterReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    // MARK: - Reactor
    enum Action {
        
    }
    
    enum Mutation {
        case setIsLoading(Bool)
    }
    
    struct State {
        var isLoading: Bool
    }
    
    let initialState: State
    // MARK: - Init
    init() {
        initialState = State(
            isLoading: false
        )
    }
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
         switch action {
         }
    }
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
         switch mutation {
         case let .setIsLoading(load):
             newState.isLoading = load
         }
        return newState
    }
    
}
