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
    }
    enum Mutation {
        case setClub(DetailClub)
        case setIsLoading(Bool)
    }
    struct State {
        var clubDetail: DetailClub?
        var isLoading: Bool
    }
    private let id: Int
    let initialState: State
    
    // MARK: - Init
    init(
        id: Int
    ) {
        self.id = id
        initialState = State(
            isLoading: false
        )
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
            .init(id: 0,
                  bannerUrl: "https://avatars.githubusercontent.com/u/74440939?v=4",
                  name: "asdf",
                  description: "대충설명대충설명대충설명\n대충설명대충설명\n대충설명대충설명대충설명대충설명대충설명",
                  activities: [
                    "https://avatars.githubusercontent.com/u/81291116?s=48&v=4",
                    "https://avatars.githubusercontent.com/u/81291116?s=48&v=4"
                  ], members: [
                    .init(id: .init(), profileImage: "https://avatars.githubusercontent.com/u/81291116?s=48&v=4", name: "asdf", grade: 1, class: 2, number: 3)
                  ],
                  head: .init(id: .init(), profileImage: "https://avatars.githubusercontent.com/u/74440939?v=4", name: "bae", grade: 3, class: 2, number: 14),
                  teacher: .init(id: .init(), profileImage: "https://avatars.githubusercontent.com/u/81291116?s=48&v=4", name: "asdf", grade: 2, class: 3, number: 11),
                  contact: "baekteun#4235"
                 )
        ))
    }
}
