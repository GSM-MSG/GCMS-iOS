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
        case acceptButtonDidTap(User)
        case rejectButtonDidTap(User)
        case kickButtonDidTap(Member)
        case delegationButtonDidTap(Member)
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
    private let userAcceptUseCase: UserAcceptUseCase
    private let userRejectUseCase: UserRejectUseCase
    private let clubDelegationUseCase: ClubDelegationUseCase
    private let userKickUseCase: UserKickUseCase
    
    // MARK: - Init
    init(
        query: ClubRequestQuery,
        clubOpenUseCase: ClubOpenUseCase,
        clubCloseUseCase: ClubCloseUseCase,
        fetchClubMemberUseCase: FetchClubMemberUseCase,
        fetchClubApplicantUseCase: FetchClubApplicantUseCase,
        userAcceptUseCase: UserAcceptUseCase,
        userRejectUseCase: UserRejectUseCase,
        clubDelegationUseCase: ClubDelegationUseCase,
        userKickUseCase: UserKickUseCase
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
        self.userAcceptUseCase = userAcceptUseCase
        self.userRejectUseCase = userRejectUseCase
        self.clubDelegationUseCase = clubDelegationUseCase
        self.userKickUseCase = userKickUseCase
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
        case let .acceptButtonDidTap(user):
            return userAcceptButtonDidTap(user: user)
        case let .rejectButtonDidTap(user):
            return userRejectButtonDidTap(user: user)
        case let .kickButtonDidTap(member):
            return userKickButtonDidTap(member: member)
        case let .delegationButtonDidTap(member):
            return delegationButtonDidTap(member: member)
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
        let members = fetchClubMemberUseCase.execute(query: query)
            .asObservable()
            .map(Mutation.setMembers)
            .catchAndReturn(Mutation.setIsLoading(false))
        let applicants = fetchClubApplicantUseCase.execute(query: query)
            .asObservable()
            .flatMap { Observable.from([Mutation.setApplicants($0), .setIsLoading(false)] )}
            .catchAndReturn(.setIsLoading(false))
        return .concat([
            startLoading,
            members,
            applicants
        ])
    }
    func userAcceptButtonDidTap(user: User) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = userAcceptUseCase.execute(query: query, userId: user.userId)
            .andThen(Observable.just(Mutation.setIsLoading(false)))
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, task])
    }
    func userRejectButtonDidTap(user: User) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = userRejectUseCase.execute(query: query, userId: user.userId)
            .andThen(Observable.just(Mutation.setIsLoading(false)))
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, task])
    }
    func userKickButtonDidTap(member: Member) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = userKickUseCase.execute(query: query, userId: member.email)
            .andThen(Observable.just(Mutation.setIsLoading(false)))
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, task])
    }
    func delegationButtonDidTap(member: Member) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = clubDelegationUseCase.execute(query: query, userId: member.email)
            .andThen(Observable.just(Mutation.setIsLoading(false)))
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, task])
    }
}
