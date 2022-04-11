import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class MyPageReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    private let logoutUseCase: LogoutUseCase
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case logoutButtonDidTap
        case updateLoading(Bool)
    }
    enum Mutation {
        case setEditorialClubList([ClubList])
        case setMajorClub(ClubList)
        case setFreedomClub(ClubList)
        case setUser(User)
        case setIsLoading(Bool)
    }
    struct State {
        var editorialClubList: [ClubList]
        var majorClub: ClubList?
        var freedomClub: ClubList?
        var isLoading: Bool
        var user: User?
    }
    let initialState: State
    
    
    // MARK: - Init
    init(
        logoutUseCase: LogoutUseCase
    ) {
        initialState = State(
            editorialClubList: [],
            isLoading: false
        )
        self.logoutUseCase = logoutUseCase
    }
    
}

// MARK: - Mutate
extension MyPageReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .logoutButtonDidTap:
            logoutButtonDidTap()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension MyPageReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setEditorialClubList(list):
            newState.editorialClubList = list
        case let .setMajorClub(club):
            newState.majorClub = club
        case let .setFreedomClub(club):
            newState.freedomClub = club
        case let .setIsLoading(load):
            newState.isLoading = load
        case let .setUser(user):
            newState.user = user
        }
        
        return newState
    }
}

// MARK: - Method
private extension MyPageReactor {
    func viewDidLoad() -> Observable<Mutation> {
        return .concat([
            .just(.setEditorialClubList([
                .dummy
            ])),
            .just(.setMajorClub(
                .dummy
            )),
            .just(.setFreedomClub(
                .dummy
            )),
            .just(.setUser(
                .dummy
            ))
        ])
    }
    func logoutButtonDidTap() {
        logoutUseCase.execute()
            .subscribe(with: self, onCompleted: { owner in
                owner.steps.accept(GCMSStep.alert(title: "로그아웃 하시겠습니까?", message: nil, style: .alert, actions: [
                    .init(title: "확인", style: .default, handler: { _ in
                        owner.steps.accept(GCMSStep.onBoardingIsRequired)
                    }),
                    .init(title: "취소", style: .cancel)
                ]))
            })
            .disposed(by: disposeBag)
    }
}
