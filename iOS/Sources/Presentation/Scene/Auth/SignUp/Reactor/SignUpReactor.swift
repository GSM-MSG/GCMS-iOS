import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class SignUpReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case updateLoading(Bool)
        case updateEmail(String)
        case certificationButtonDidTap
        case emailNotFound
    }
    enum Mutation {
        case setIsLoading(Bool)
        case setIsEmailNotFound(Bool)
        case setEmail(String)
        
    }
    struct State {
        var isLoading: Bool
        var isEmailNotFound : Bool
        var email : String
    }
    let initialState: State
    let sendVerifyUseCase: SendVerifyUseCase
    
    // MARK: - Init
    init(
        sendVerifyUseCase: SendVerifyUseCase
    ) {
        initialState = State(isLoading: false,
                             isEmailNotFound: false,
                             email: "")
        self.sendVerifyUseCase = sendVerifyUseCase
    }

}

// MARK: - Mutate
extension SignUpReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .certificationButtonDidTap:
            return certificationButton()
        case let .updateEmail(email):
            return .just(.setEmail(email))
        case .emailNotFound:
            return .just(.setIsEmailNotFound(true))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension SignUpReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setIsLoading(load):
            newState.isLoading = load
        case let .setIsEmailNotFound(success):
            newState.isEmailNotFound = success
        case let .setEmail(email):
            newState.email = email
        }
        
        return newState
    }
}

// MARK: - Method
private extension SignUpReactor {
    func certificationButton() -> Observable<Mutation> {
        
//        let startLoding = Observable.just(Mutation.setIsLoading(true))
        let signUp = sendVerifyUseCase.execute(email: currentState.email)
            .do(onError: { [weak self] err in
                print(err.localizedDescription)
                self?.action.onNext(.emailNotFound)
            }, onCompleted: {
                print("asdfasdfasfs")
                self.steps.accept(GCMSStep.certificationIsRequired)
            })
            .andThen(Single.just(Mutation.setIsLoading(false)))
            .asObservable()
            .catchAndReturn(.setIsLoading(false))
        
        return .concat(signUp)
    }
}
