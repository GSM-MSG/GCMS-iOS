import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class AcceptReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case setUser([User])
    }
    struct State {
        var acceptUser: [User]
    }
    private let id : Int
    let initialState: State
    
    // MARK: - Init
    init(
        id: Int
    ) {
        self.id = id
        initialState = State(acceptUser: [])
    }
    
}

// MARK: - Mutate
extension AcceptReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .viewDidLoad:
            return viewDidLoad()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension AcceptReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case let .setUser(user):
            newState.acceptUser = user
        }
        
        return newState
    }
}

// MARK: - Method
private extension AcceptReactor {
    
    func viewDidLoad() -> Observable<Mutation> {
        return .just(.setUser([
        .init(id: 0, picture: "https://avatars.githubusercontent.com/u/74440939?v=4", name: "변찬우", grade: 1, class: 3, number: 4, joinedMajorClub: 1, joinedEditorialClub: [1,2], joinedFreedomClub: 1),
        .init(id: 1, picture: "https://avatars.githubusercontent.com/u/74440939?v=4", name: "변찬우", grade: 1, class: 3, number: 4, joinedMajorClub: 1, joinedEditorialClub: [1,2], joinedFreedomClub: 1),
        .init(id: 2, picture: "https://avatars.githubusercontent.com/u/74440939?v=4", name: "변찬우", grade: 1, class: 3, number: 4, joinedMajorClub: 1, joinedEditorialClub: [1,2], joinedFreedomClub: 1)
        ]))
    }
    
}
