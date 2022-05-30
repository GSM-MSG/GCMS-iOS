import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class ClubMemberReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case sectionDidTap(Int, Bool)
        case viewDidLoad
    }
    enum Mutation {
        case setIsOpened(Int, Bool)
        case setUsers([ExpandableMemberSection])
        case appendUsers(ExpandableMemberSection)
        case setIsLoading(Bool)
    }
    struct State {
        var users: [ExpandableMemberSection]
        var isLoading: Bool
        var isOpened: Bool
    }
    let initialState: State
    private let query: ClubRequestQuery
    
    private let fetchClubMemberUseCase: FetchClubMemberUseCase
    private let fetchClubApplicantUseCase: FetchClubApplicantUseCase
    private let userKickUseCase: UserKickUseCase
    private let clubDelegationUseCase: ClubDelegationUseCase
    private let userAcceptUseCase: UserAcceptUseCase
    private let userRejectUseCase: UserRejectUseCase
    private let clubOpenUseCase: ClubOpenUseCase
    private let clubCloseUseCase: ClubCloseUseCase
    
    // MARK: - Init
    init(
        query: ClubRequestQuery,
        isOpened: Bool,
        fetchClubMemberUseCase: FetchClubMemberUseCase,
        fetchClubApplicantUseCase: FetchClubApplicantUseCase,
        userKickUseCase: UserKickUseCase,
        clubDelegationUseCase: ClubDelegationUseCase,
        userAcceptUseCase: UserAcceptUseCase,
        userRejectUseCase: UserRejectUseCase,
        clubOpenUseCase: ClubOpenUseCase,
        clubCloseUseCase: ClubCloseUseCase
    ) {
        self.fetchClubMemberUseCase = fetchClubMemberUseCase
        self.fetchClubApplicantUseCase = fetchClubApplicantUseCase
        self.userKickUseCase = userKickUseCase
        self.clubDelegationUseCase = clubDelegationUseCase
        self.userAcceptUseCase = userAcceptUseCase
        self.userRejectUseCase = userRejectUseCase
        self.clubOpenUseCase = clubOpenUseCase
        self.clubCloseUseCase = clubCloseUseCase
        
        initialState = State(
            users: [],
            isLoading: false,
            isOpened: isOpened
        )
        self.query = query
    }
    
}

// MARK: - Mutate
extension ClubMemberReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .sectionDidTap(index, open):
            return .just(.setIsOpened(index, open))
        case .viewDidLoad:
            return viewDidLoad()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension ClubMemberReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setIsOpened(index, open):
            newState.users[index].isOpened = open
        case let .setUsers(section):
            newState.users = section
        case let .appendUsers(section):
            newState.users.append(section)
        case let .setIsLoading(load):
            newState.isLoading = load
        }
        
        return newState
    }
}

// MARK: - Method
private extension ClubMemberReactor {
    func viewDidLoad() -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let member = fetchClubMemberUseCase.execute(query: query)
            .asObservable()
            .map { ExpandableMemberSection(header: "구성원", items: $0.map { MemberSectionType.member($0) }, isOpened: false) }
            .flatMap { Observable.concat([
                Observable.just(Mutation.setIsLoading(false)),
                .just(.appendUsers($0))
            ]) }
            .catchAndReturn(.setIsLoading(false))
        let applicant = fetchClubApplicantUseCase.execute(query: query)
            .asObservable()
            .map { ExpandableMemberSection(header: "가입 대기자 명단", items: $0.map { MemberSectionType.applicant($0) }, isOpened: false) }
            .flatMap { Observable.concat([
                Observable.just(Mutation.setIsLoading(false)),
                .just(.appendUsers($0))
            ]) }
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, member, applicant])
    }
}
