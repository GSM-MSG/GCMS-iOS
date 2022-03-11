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
            .init(
                id: 1,
                bannerUrl: "https://avatars.githubusercontent.com/u/74440939?s=70&v=4",
                name: "with권",
                description: "대충설명대충설명대충설명대충설명\n대충설명\n\n대충설명대충설명",
                activities: [
                    "https://avatars.githubusercontent.com/u/95753750?s=200&v=4",
                    "https://avatars.githubusercontent.com/u/82383294?s=70&v=4",
                    "https://avatars.githubusercontent.com/u/82383983?s=70&v=4"
                ],
                members: [
                    .init(
                        id: 1,
                        picture: "https://avatars.githubusercontent.com/u/82383983?s=70&v=4",
                        name: "현빈리",
                        grade: 2,
                        class: 1,
                        number: 14
                    )
                ],
                head: "누구였지?",
                teacher: "강권",
                contact: "AAAA#1234",
                isDeadline: false,
                isHead: false,
                isApplied: false
            )
        ))
    }
}
