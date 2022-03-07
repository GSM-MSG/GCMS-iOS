import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class AcceptReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        
    }
    enum Mutation {
        
    }
    struct State {
        
    }
    private let id : Int
    let initialState: State
    
    // MARK: - Init
    init(
        id: Int
    ) {
        self.id = id
        initialState = State()
    }
    
}

// MARK: - Mutate
extension AcceptReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
}

// MARK: - Reduce
extension AcceptReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}

// MARK: - Method
private extension AcceptReactor {
    
}
