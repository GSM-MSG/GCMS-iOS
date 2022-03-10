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
        
    }
    enum Mutation {
        
    }
    struct State {
        
    }
    let initialState: State
    private let id: Int
    
    // MARK: - Init
    init(
        id: Int
    ) {
        self.id = id
        initialState = State()
    }
    
}

// MARK: - Mutate
extension NoticeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
}

// MARK: - Reduce
extension NoticeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}

// MARK: - Method
private extension NoticeReactor {
    
}
