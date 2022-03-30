import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class MyPageReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case updateLoading(Bool)
    }
    enum Mutation {
        case setEditorialClubList([ClubList])
        case setMajorClub(ClubList)
        case setFreedomClub(ClubList)
        case setIsLoading(Bool)
    }
    struct State {
        var editorialClubList: [ClubList]
        var majorClub: ClubList?
        var freedomClub: ClubList?
        var isLoading: Bool
    }
    let initialState: State
    
    
    // MARK: - Init
    init(
        
    ) {
        initialState = State(
            editorialClubList: [],
            isLoading: false
        )
        
        
    }
    
}

// MARK: - Mutate
extension MyPageReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension MyPageReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setEditorialClubList(list):
            newState.editorialClubList = list
        case let .setMajorClub(club):
            newState.majorClub = club
        case let .setFreedomClub(club):
            newState.freedomClub = club
        case let .setIsLoading(load):
            newState.isLoading = load
        }
        
        return newState
    }
}

// MARK: - Method
private extension MyPageReactor {
    func viewDidLoad() -> Observable<Mutation> {
        return .concat([
            .just(.setEditorialClubList([
                .dummy
            ])),
            .just(.setMajorClub(
                .dummy
            )),
            .just(.setFreedomClub(
                .dummy
            ))
        ])
    }
    
}
