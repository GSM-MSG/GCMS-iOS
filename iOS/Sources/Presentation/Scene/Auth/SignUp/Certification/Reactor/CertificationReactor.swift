import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import RxMoya
import Service
import Foundation

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
    }
    enum Mutation {
        case setIsLoading(Bool)
        case setCode(String)
    }
    struct State {
        var isLoading: Bool
        var code : String
    }
    let initialState: State
    private let checkIsVerifiedUseCase : CheckIsVerifiedUseCase
    private var email : String
    
    // MARK: - Init
    init(
        checkIsVerifiedUseCase : CheckIsVerifiedUseCase,
        email : String
    ) {
        initialState = State(isLoading: false, code: "")
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
            return completeButtonDidTap()
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
        }
        return newState
    }
}

// MARK: - Method
private extension CertificationReactor {
    func completeButtonDidTap() -> Observable<Mutation> {
        
        let startLoding = Observable.just(Mutation.setIsLoading(true))
        let signUp = checkIsVerifiedUseCase.execute(email: email, code: currentState.code)
            .do(onError: { [weak self] _ in
                self?.steps.accept(GCMSStep.loaf("인증코드가 다릅니다!", state: .error, location: .top))
            }, onCompleted: { [weak self] in
                self?.steps.accept(GCMSStep.dismiss)
            })
            .andThen(Single.just(Mutation.setIsLoading(false)))
            .asObservable()
            .catchAndReturn(.setIsLoading(false))
        return .concat([startLoding, signUp])
    }
}
