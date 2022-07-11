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
        case delegationButtonDidTap(Member)
        case kickButtonDidTap(Member)
        case acceptButtonDidTap(User)
        case rejectButtonDidTap(User)
        case clubOpenCloseButtonDidTap
        case clubIsOpenedChange(Bool)
    }
    enum Mutation {
        case setClubIsOpened(Bool)
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
        case let .delegationButtonDidTap(user):
            return delegationButtonDidTap(user: user)
        case let .kickButtonDidTap(user):
            return kicknButtonDidTap(user: user)
        case let .acceptButtonDidTap(user):
            return acceptButtonDidTap(user: user)
        case let .rejectButtonDidTap(user):
            return rejectButtonDidTap(user: user)
        case .clubOpenCloseButtonDidTap:
            return clubOpenCloseButtonDidTap()
        case let .clubIsOpenedChange(isOpened):
            return .just(.setClubIsOpened(isOpened))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension ClubMemberReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setClubIsOpened(isOpened):
            newState.isOpened = isOpened
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
        let start = Observable.concat([
            .just(Mutation.setIsLoading(true)),
            .just(.setUsers([]))
        ])
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
    func clubOpenCloseButtonDidTap() -> Observable<Mutation> {
        if currentState.isOpened {
            self.steps.accept(GCMSStep.alert(title: "마감하기", message: "동아리 신청을 마감하시겠습니까?", style: .alert, actions: [
                .init(title: "마감", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.clubCloseUseCase.execute(query: self.query)
                        .andThen(Observable.just(()))
                        .subscribe { _ in
                            self.action.onNext(.clubIsOpenedChange(false))
                            self.steps.accept(GCMSStep.alert(title: "성공", message: "동아리 신청이 마감되었습니다.", style: .alert, actions: [.init(title: "확인", style: .default)]))
                        } onError: { e in
                            self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                        }
                        .disposed(by: self.disposeBag)
                }),
                .init(title: "취소", style: .cancel)
            ]))
        } else {
            self.steps.accept(GCMSStep.alert(title: "신청받기", message: "동아리 신청을 받겠습니까?", style: .alert, actions: [
                .init(title: "받기", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.clubOpenUseCase.execute(query: self.query)
                        .andThen(Observable.just(()))
                        .subscribe { _ in
                            self.action.onNext(.clubIsOpenedChange(true))
                            self.steps.accept(GCMSStep.alert(title: "성공", message: "동아리 신청이 열렸습니다.", style: .alert, actions: [.init(title: "확인", style: .default)]))
                        } onError: { e in
                            self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                        }
                        .disposed(by: self.disposeBag)
                }),
                .init(title: "취소", style: .cancel)
            ]))
        }
        return .empty()
    }
    func delegationButtonDidTap(user: Member) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "위임하기", message: "정말 '\(user.name)'님을 부장으로 위임하시겠습니까?", style: .alert, actions: [
            .init(title: "위임", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubDelegationUseCase.execute(query: self.query, userId: user.email)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.popToRoot)
                        self.action.onNext(.viewDidLoad)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func kicknButtonDidTap(user: Member) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "추방하기", message: "정말 '\(user.name)'님을 추방하시겠습니까?", style: .alert, actions: [
            .init(title: "추방", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.userKickUseCase.execute(query: self.query, userId: user.email)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.alert(title: "성공", message: "성공적으로 '\(user.name)'님을 추방했습니다", style: .alert, actions: [.init(title: "확인", style: .default)]))
                        self.action.onNext(.viewDidLoad)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func acceptButtonDidTap(user: User) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "가입 승인하기", message: "정말 '\(user.name)'님의 가입을 승인하시겠습니까?", style: .alert, actions: [
            .init(title: "승인", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.userAcceptUseCase.execute(query: self.query, userId: user.userId)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.alert(title: "성공", message: "성공적으로 '\(user.name)'님의 가입을 승인했습니다", style: .alert, actions: [.init(title: "확인", style: .default)]))
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func rejectButtonDidTap(user: User) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "가입 거절하기", message: "정말 '\(user.name)'님의 가입을 거절하시겠습니까?", style: .alert, actions: [
            .init(title: "거절", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.userRejectUseCase.execute(query: self.query, userId: user.userId)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.alert(title: "성공", message: "성공적으로 '\(user.name)'님의 가입을 거절했습니다", style: .alert, actions: [.init(title: "확인", style: .default)]))
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
}
