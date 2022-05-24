import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import Foundation

class AfterSchoolReactor: Reactor, Stepper {
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
    
    init() {
        initialState = State(
            isLoading: false
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
         switch action {
         }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
         switch mutation {
         case let .setIsLoading(load):
             newState.isLoading = load
         }
        return newState
    }
    
}
