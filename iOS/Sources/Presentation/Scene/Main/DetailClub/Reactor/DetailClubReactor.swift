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
        case setClub(Club)
        case setIsLoading(Bool)
    }
    struct State {
        var clubDetail: Club?
        var isLoading: Bool
    }
    let initialState: State
    
    // MARK: - Init
    init(
    
    ) {
        
        
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
                type: .editorial,
                bannerUrl: "https://avatars.githubusercontent.com/u/81547954?s=40&v=4",
                title: "title",
                description: "desc",
                contact: "연",
                head: .init(
                    userId: "asdf",
                    profileImageUrl: "https://avatars.githubusercontent.com/u/12152522?s=60&v=4",
                    name: "dan",
                    grade: 1,
                    class: 2,
                    number: 3,
                    joinedMajorClub: nil,
                    joinedFreedomClub: nil,
                    joinedEditorialClub: nil
                ),
                relatedLink: [],
                scope: .default,
                isApplied: falㅣse,
                isOpen: false,
                activities: [],
                member: [
                    .init(
                        userId: "s2103",
                        profileImageUrl: "https://camo.githubusercontent.com/89a9989573e7036f8fea68e8e31fd546f10f31dc6b9126c855913a1c70c0ff0c/68747470733a2f2f74656368737461636b2d67656e657261746f722e76657263656c2e6170702f73776966742d69636f6e2e737667",
                        name: "ㅇㅈ",
                        grade: 2,
                        class: 2,
                        number: 2,
                        joinedMajorClub: nil,
                        joinedFreedomClub: nil,
                        joinedEditorialClub: nil
                    )
                ],
                teacher: nil
            )
        ))
    }
}
