import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class HomeReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    private let fetchClubListsUseCase: FetchClubListUseCase
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case myPageButtonDidTap
        case newClubButtonDidTap
        case updateLoading(Bool)
        case clubDidTap(ClubRequestQuery)
    }
    enum Mutation {
        case setClubList(ClubType, [ClubList])
        case setIsLoading(Bool)
        case setClubType(ClubType)
    }
    struct State {
        var majorClubList: [ClubList]
        var freedomClubList: [ClubList]
        var editorialClubList: [ClubList]
        var clubType: ClubType
        var isLoading: Bool
    }
    let initialState: State
    
    // MARK: - Init
    init(
        fetchClubListsUseCase: FetchClubListUseCase
    ) {
        initialState = State(
            majorClubList: [],
            freedomClubList: [],
            editorialClubList: [],
            clubType: .major,
            isLoading: false
        )
        self.fetchClubListsUseCase = fetchClubListsUseCase
    }
    
}

// MARK: - Mutate
extension HomeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .myPageButtonDidTap:
            steps.accept(GCMSStep.myPageIsRequired)
        case .newClubButtonDidTap:
            steps.accept(GCMSStep.firstNewClubIsRequired)
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .viewDidLoad:
            return viewDidLoad()
        case let .clubDidTap(query):
            steps.accept(GCMSStep.clubDetailIsRequired(query: query))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension HomeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setClubList(type, lists):
            switch type{
            case .major: newState.majorClubList = lists
            case .freedom: newState.freedomClubList = lists
            case .editorial: newState.editorialClubList = lists
            }
        case let .setIsLoading(load):
            newState.isLoading = load
        case let .setClubType(type):
            newState.clubType = type
        }
        
        return newState
    }
}

// MARK: - Method
private extension HomeReactor {
    func viewDidLoad() -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let clubs = Observable.zip(
            fetchClubListsUseCase.execute(type: .major).asObservable(),
            fetchClubListsUseCase.execute(type: .editorial).asObservable(),
            fetchClubListsUseCase.execute(type: .freedom).asObservable()
        ).flatMap { major, editorial, freedom in
            return Observable.concat([
                .just(Mutation.setClubList(.major, major)),
                .just(.setClubList(.editorial, editorial)),
                .just(.setClubList(.freedom, freedom)),
                .just(.setIsLoading(false))
            ])
        }.catchAndReturn(Mutation.setIsLoading(false))
        return .concat([start, clubs])
    }
}
