import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class CertificationReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case updateLoading(Bool)
        case dismiss
        case updateCode(String)
        case completeButotnDidTap
        case codeNotMatch
    }
    enum Mutation {
        case setIsLoading(Bool)
        case setCode(String)
        case setCodeNotMatch(Bool)
    }
    struct State {
        var isLoading: Bool
        var isCodeNotMatch : Bool
        var code : String
    }
    let initialState: State
    
    let checkIsVerifiedUseCase : CheckIsVerifiedUseCase
    var email : String
    
    // MARK: - Init
    init(
        checkIsVerifiedUseCase : CheckIsVerifiedUseCase,
        email : String
    ) {
        initialState = State(isLoading: false, isCodeNotMatch: false, code: "")
        self.checkIsVerifiedUseCase = checkIsVerifiedUseCase
        self.email = email
    }
    
}

// MARK: - Mutate
extension CertificationReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .dismiss:
            steps.accept(GCMSStep.dismiss)
        case let .updateCode(code):
            return .just(.setCode(code))
        case .completeButotnDidTap:
            return completeButotnDidTap()
        case .codeNotMatch:
            return .just(.setCodeNotMatch(true))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension CertificationReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setIsLoading(load):
            newState.isLoading = load
        case let .setCode(code):
            newState.code = code
        case let .setCodeNotMatch(match):
            newState.isCodeNotMatch = match
        }
        
        return newState
    }
}

// MARK: - Method
private extension CertificationReactor {
    func completeButotnDidTap() -> Observable<Mutation> {
        let startLoding = Observable.just(Mutation.setIsLoading(true))
        let signUp = checkIsVerifiedUseCase.execute(email: email, code: currentState.code)
            .do(onError: { [weak self] _ in
                self?.action.onNext(.codeNotMatch)
            }, onCompleted: {
                self.steps.accept(GCMSStep.dismiss)
            })
            .andThen(Single.just(Mutation.setIsLoading(false)))
            .asObservable()
            .catchAndReturn(.setIsLoading(false))
        return .concat([startLoding, signUp])
    }
}
