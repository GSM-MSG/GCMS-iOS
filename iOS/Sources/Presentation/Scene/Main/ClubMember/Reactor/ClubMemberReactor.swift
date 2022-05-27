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
    }
    enum Mutation {
        case setIsOpened(Int, Bool)
    }
    struct State {
        var users: [ExpandableMemberSection]
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
            users: [
                .init(header: "멤버", items: [.member(.dummy), .member(.dummy)], isOpened: false),
                .init(header: "지원자", items: [.applicant(.dummy), .applicant(.dummy)], isOpened: false)
            ]
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
        }
        
        return newState
    }
}

// MARK: - Method
private extension ClubMemberReactor {
    
}
