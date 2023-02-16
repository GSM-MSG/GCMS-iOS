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
        case viewDidAppear(ClubType)
        case myPageButtonDidTap
        case newClubButtonDidTap
        case updateLoading(Bool)
        case clubDidTap(Int)
        case guestLogoutButtonDidTap
        case appleExitButtonDidTap
        case refreshTrigger(ClubType)
    }
    enum Mutation {
        case setClubList(ClubType, [ClubList])
        case setIsLoading(Bool)
        case setClubType(ClubType)
        case setIsRefreshing(Bool)
    }
    struct State {
        var majorClubList: [ClubList]
        var freedomClubList: [ClubList]
        var editorialClubList: [ClubList]
        var clubType: ClubType
        var isLoading: Bool
        var isRefreshing: Bool
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
            isLoading: false,
            isRefreshing: false
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
            steps.accept(GCMSStep.firstNewClubIsRequired())
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .viewDidLoad:
            return viewDidLoad()
        case let .clubDidTap(clubID):
            steps.accept(GCMSStep.clubDetailIsRequired(clubID: clubID))
        case .guestLogoutButtonDidTap:
            return guestLogoutButtonDidTap()
        case let .refreshTrigger(type):
            return refresh(type: type)
        case let .viewDidAppear(type):
            return .just(.setClubType(type))
        case .appleExitButtonDidTap:
            return appleExitButtonDidTap()
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
        case let .setIsRefreshing(refresh):
            newState.isRefreshing = refresh
        }
        
        return newState
    }
}

// MARK: - Method
private extension HomeReactor {
    func viewDidLoad() -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let clubs: Observable<([ClubList], [ClubList], [ClubList])> = Observable.zip(
            fetchClubListsUseCase.execute(type: .major).asObservable(),
            fetchClubListsUseCase.execute(type: .editorial).asObservable(),
            fetchClubListsUseCase.execute(type: .freedom).asObservable()
        )
        let res = clubs
            .flatMap { major, editorial, freedom in
                return Observable.concat([
                    .just(Mutation.setClubList(.major, major)),
                    .just(.setClubList(.editorial, editorial)),
                    .just(.setClubList(.freedom, freedom)),
                    .just(.setIsLoading(false))
                ])
            }.catchAndReturn(Mutation.setIsLoading(false))
        return .concat([start, res])
    }
    func guestLogoutButtonDidTap() -> Observable<Mutation> {
        steps.accept(GCMSStep.alert(title: nil, message: "게스트 계정을 로그아웃 하시겠습니까?", style: .alert, actions: [
            .init(title: "확인", style: .default, handler: { [weak self] _ in
                UserDefaultsLocal.shared.isGuest = false
                self?.steps.accept(GCMSStep.onBoardingIsRequired)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func refresh(type: ClubType) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = fetchClubListsUseCase.execute(type: type)
            .asObservable()
            .flatMap { list in
                Observable.concat([
                    Observable.just(Mutation.setClubList(type, list)),
                    .just(.setIsLoading(false)),
                    .just(.setIsRefreshing(false))
                ])
            }
            .catchAndReturn(Mutation.setIsLoading(false))
        return .concat([start, task])
    }
    func appleExitButtonDidTap() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "회원탈퇴", message: "정말로 탈퇴하시겠습니까?", style: .alert, actions: [
            .init(title: "탈퇴", style: .destructive, handler: { [weak self] _ in
                self?.revokeToken()
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func revokeToken() {
    }
}
