import ReactorKit
import RxFlow
import RxSwift
import RxRelay

final class OnBoardingReactor: Reactor, Stepper {
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
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension OnBoardingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
        return .empty()
    }
}

// MARK: - Reduce
extension OnBoardingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}

// MARK: - Method
private extension OnBoardingReactor {
    
}
