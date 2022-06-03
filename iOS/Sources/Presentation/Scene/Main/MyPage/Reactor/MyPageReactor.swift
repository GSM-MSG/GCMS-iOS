import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import Foundation

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
        case profileImageDidTap(Data)
    }
    enum Mutation {
        case setUser(UserProfile)
        case setIsLoading(Bool)
    }
    struct State {
        var isLoading: Bool
        var user: UserProfile?
    }
    let initialState: State
    private let fetchProfileUseCase: FetchProfileUseCase
    private let logoutUseCase: LogoutUseCase
    private let uploadImagesUseCase: UploadImagesUseCase
    private let updateProfileImageUseCase: UpdateProfileImageUseCase
    private let withdrawalUseCase: WithdrawalUseCase
    
    // MARK: - Init
    init(
        logoutUseCase: LogoutUseCase,
        fetchProfileUseCase: FetchProfileUseCase,
        uploadImagesUseCase: UploadImagesUseCase,
        updateProfileImageUseCase: UpdateProfileImageUseCase,
        withdrawalUseCase: WithdrawalUseCase
    ) {
        initialState = State(
            isLoading: false
        )
        self.logoutUseCase = logoutUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
        self.uploadImagesUseCase = uploadImagesUseCase
        self.updateProfileImageUseCase = updateProfileImageUseCase
        self.withdrawalUseCase = withdrawalUseCase
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
        case let .profileImageDidTap(data):
            return profileChange(data: data)
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
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = fetchProfileUseCase.execute()
            .asObservable()
            .flatMap { Observable.from([Mutation.setUser($0), .setIsLoading(false)])}
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, task])
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
    func profileChange(data: Data) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = uploadImagesUseCase.execute(images: [data])
            .compactMap(\.first)
            .asObservable()
            .withUnretained(self)
            .flatMap { owner, url in
                owner.updateProfileImageUseCase.execute(imageUrl: url)
                    .andThen(Observable.just(Mutation.setIsLoading(false)))
            }
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, task])
    }
}
