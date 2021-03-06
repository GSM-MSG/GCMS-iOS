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
            .map { ExpandableMemberSection(header: "?????????", items: $0.map { MemberSectionType.member($0) }, isOpened: false) }
            .flatMap { Observable.concat([
                Observable.just(Mutation.setIsLoading(false)),
                .just(.appendUsers($0))
            ]) }
            .catch { [weak self] e in
                self?.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription, action: []))
                return .just(.setIsLoading(false))
            }
        let applicant = fetchClubApplicantUseCase.execute(query: query)
            .asObservable()
            .map { ExpandableMemberSection(header: "?????? ????????? ??????", items: $0.map { MemberSectionType.applicant($0) }, isOpened: false) }
            .flatMap { Observable.concat([
                Observable.just(Mutation.setIsLoading(false)),
                .just(.appendUsers($0))
            ]) }
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, member, applicant])
    }
    func clubOpenCloseButtonDidTap() -> Observable<Mutation> {
        if currentState.isOpened {
            self.steps.accept(GCMSStep.alert(title: "????????????", message: "????????? ????????? ?????????????????????????", style: .alert, actions: [
                .init(title: "??????", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.clubCloseUseCase.execute(query: self.query)
                        .andThen(Observable.just(()))
                        .subscribe { _ in
                            self.action.onNext(.clubIsOpenedChange(false))
                            self.steps.accept(GCMSStep.alert(title: "??????", message: "????????? ????????? ?????????????????????.", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        } onError: { e in
                            self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                        }
                        .disposed(by: self.disposeBag)
                }),
                .init(title: "??????", style: .cancel)
            ]))
        } else {
            self.steps.accept(GCMSStep.alert(title: "????????????", message: "????????? ????????? ????????????????", style: .alert, actions: [
                .init(title: "??????", style: .default, handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.clubOpenUseCase.execute(query: self.query)
                        .andThen(Observable.just(()))
                        .subscribe { _ in
                            self.action.onNext(.clubIsOpenedChange(true))
                            self.steps.accept(GCMSStep.alert(title: "??????", message: "????????? ????????? ???????????????.", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        } onError: { e in
                            self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                        }
                        .disposed(by: self.disposeBag)
                }),
                .init(title: "??????", style: .cancel)
            ]))
        }
        return .empty()
    }
    func delegationButtonDidTap(user: Member) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "????????????", message: "?????? '\(user.name)'?????? ???????????? ?????????????????????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubDelegationUseCase.execute(query: self.query, userId: user.email)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.popToRoot)
                        self.action.onNext(.viewDidLoad)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
    func kicknButtonDidTap(user: Member) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "????????????", message: "?????? '\(user.name)'?????? ?????????????????????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.userKickUseCase.execute(query: self.query, userId: user.email)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.alert(title: "??????", message: "??????????????? '\(user.name)'?????? ??????????????????", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        self.action.onNext(.viewDidLoad)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
    func acceptButtonDidTap(user: User) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "?????? ????????????", message: "?????? '\(user.name)'?????? ????????? ?????????????????????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.userAcceptUseCase.execute(query: self.query, userId: user.userId)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.alert(title: "??????", message: "??????????????? '\(user.name)'?????? ????????? ??????????????????", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        self.action.onNext(.viewDidLoad)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
    func rejectButtonDidTap(user: User) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "?????? ????????????", message: "?????? '\(user.name)'?????? ????????? ?????????????????????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.userRejectUseCase.execute(query: self.query, userId: user.userId)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.alert(title: "??????", message: "??????????????? '\(user.name)'?????? ????????? ??????????????????", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        self.action.onNext(.viewDidLoad)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
}
