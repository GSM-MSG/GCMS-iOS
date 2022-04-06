import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class DetailClubReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case updateLoading(Bool)
        case statusButtonDidTap
    }
    enum Mutation {
        case setClub(Club)
        case setIsLoading(Bool)
    }
    struct State {
        var clubDetail: Club?
        var isLoading: Bool
    }
    let initialState: State
    private let query: ClubRequestQuery
    
    // MARK: - Init
    init(
        query: ClubRequestQuery
    ) {
        initialState = State(
            isLoading: false
        )
        self.query = query
    }
    
}

// MARK: - Mutate
extension DetailClubReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .statusButtonDidTap:
            steps.accept(GCMSStep.clubStatusIsRequired(query: query, isHead: currentState.clubDetail?.scope == .head ?? .default))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension DetailClubReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setClub(club):
            newState.clubDetail = club
        case let .setIsLoading(load):
            newState.isLoading = load
        }
        
        return newState
    }
}

// MARK: - Method
private extension DetailClubReactor {
    func viewDidLoad() -> Observable<Mutation> {
        
        return .just(.setClub(
            .dummy
        ))
    }
}
