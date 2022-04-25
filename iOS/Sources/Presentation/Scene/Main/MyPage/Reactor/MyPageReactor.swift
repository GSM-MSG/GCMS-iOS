import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class MyPageReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case logoutButtonDidTap
        case updateLoading(Bool)
        case clubDidTap(ClubRequestQuery)
    }
    enum Mutation {
        case setUser(UserProfile)
        case setIsLoading(Bool)
    }
    struct State {
        var isLoading: Bool
        var user: UserProfile?
    }
    private let fetchProfileUseCase: FetchProfileUseCase
    private let logoutUseCase: LogoutUseCase
    let initialState: State
    
    
    // MARK: - Init
    init(
        logoutUseCase: LogoutUseCase,
        fetchProfileUseCase: FetchProfileUseCase
    ) {
        initialState = State(
            isLoading: false
        )
        self.fetchProfileUseCase = fetchProfileUseCase
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
        case let .clubDidTap(q):
            steps.accept(GCMSStep.clubDetailIsRequired(query: q))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension MyPageReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
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
