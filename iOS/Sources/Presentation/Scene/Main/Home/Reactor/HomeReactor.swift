import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class HomeReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case segmentDidTap(ClubType)
        case myPageButtonDidTap
        case alarmButtonDidTap
        case updateLoading(Bool)
        case clubDidTap(ClubRequestQuery)
    }
    enum Mutation {
        case setClubList([ClubList])
        case setIsLoading(Bool)
        case setClubType(ClubType)
    }
    struct State {
        var clubList: [ClubListSection]
        var clubType: ClubType
        var isLoading: Bool
    }
    let initialState: State
    
    // MARK: - Init
    init(
        
    ) {
        
        initialState = State(
            clubList: [],
            clubType: .major,
            isLoading: false
        )
    }
    
}

// MARK: - Mutate
extension HomeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case .myPageButtonDidTap:
            steps.accept(GCMSStep.myPageIsRequired)
        case .alarmButtonDidTap:
            steps.accept(GCMSStep.alarmListIsRequired)
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case let .segmentDidTap(type):
            return .just(.setClubType(type))
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
        case let .setClubList(lists):
            newState.clubList = [ClubListSection(header: "", items: lists)]
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
        
        return .just(.setClubList([
            .dummy,
            .dummy,
            .dummy,
            .dummy
        ]))
    }
}
