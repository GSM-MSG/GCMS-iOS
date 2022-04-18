import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class ClubStatusReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case updateLoading(Bool)
        case viewDidLoad
    }
    enum Mutation {
        case setIsLoading(Bool)
        case setMembers([Member])
        case setApplicants([User])
    }
    struct State {
        var isLoading: Bool
        var members: [Member]
        var applicants: [User]
    }
    let initialState: State
    private let query: ClubRequestQuery
    private let clubOpenUseCase: ClubOpenUseCase
    private let clubCloseUseCase: ClubCloseUseCase
    private let fetchClubMemberUseCase: FetchClubMemberUseCase
    private let fetchClubApplicantUseCase: FetchClubApplicantUseCase
    
    // MARK: - Init
    init(
        query: ClubRequestQuery,
        clubOpenUseCase: ClubOpenUseCase,
        clubCloseUseCase: ClubCloseUseCase,
        fetchClubMemberUseCase: FetchClubMemberUseCase,
        fetchClubApplicantUseCase: FetchClubApplicantUseCase
    ) {
        initialState = State(
            isLoading: false,
            members: [],
            applicants: []
        )
        self.query = query
        self.clubOpenUseCase = clubOpenUseCase
        self.clubCloseUseCase = clubCloseUseCase
        self.fetchClubMemberUseCase = fetchClubMemberUseCase
        self.fetchClubApplicantUseCase = fetchClubApplicantUseCase
    }
    
}

// MARK: - Mutate
extension ClubStatusReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .viewDidLoad:
            return viewDidLoad()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension ClubStatusReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setIsLoading(load):
            newState.isLoading = load
        case let .setMembers(member):
            newState.members = member
        case let .setApplicants(users):
            newState.applicants = users
        }
        
        return newState
    }
}

// MARK: - Method
private extension ClubStatusReactor {
    func viewDidLoad() -> Observable<Mutation> {
        let startLoading = Observable.just(Mutation.setIsLoading(true))
        let members: [Member] = [
            .dummy,
            .dummy,
            .dummy
        ]
        let applicants: [User] = [
            .dummy,
            .dummy
        ]
        let stopLoading = Observable.just(Mutation.setIsLoading(false))
        return .concat([
            startLoading,
            .just(.setMembers(members)),
            .just(.setApplicants(applicants)),
            stopLoading
        ])
    }
}
