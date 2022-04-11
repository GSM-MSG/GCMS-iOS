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
        case updatePassword(String)
        case certificationButtonDidTap
        case completeButtonDidTap
        case emailNotFound
        case signUpFailed
    }
    enum Mutation {
        case setIsLoading(Bool)
        case setIsEmailNotFound(Bool)
        case setPassword(String)
        case setEmail(String)
        case setIsSignUpFailed(Bool)
    }
    struct State {
        var isLoading: Bool
        var isSignUpFailed: Bool
        var isEmailNotFound : Bool
        var email : String
        var password : String
    }
    let initialState: State
    let sendVerifyUseCase: SendVerifyUseCase
    let registerUseCase : RegisterUseCase
    
    // MARK: - Init
    init(
        sendVerifyUseCase: SendVerifyUseCase,
        registerUseCase : RegisterUseCase
    ) {
        initialState = State(isLoading: false,
                             isSignUpFailed: false,
                             isEmailNotFound: false,
                             email: "",
                             password: "")
        self.sendVerifyUseCase = sendVerifyUseCase
        self.registerUseCase = registerUseCase
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
        case .completeButtonDidTap:
            return completeButtonDidTap()
        case .signUpFailed:
            return .just(.setIsSignUpFailed(true))
        case let .updatePassword(password):
            return .just(.setPassword(password))
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
            newState.isSignUpFailed = false
            newState.isEmailNotFound = false
        case let .setIsSignUpFailed(success):
            newState.isSignUpFailed = success
        case let .setPassword(password):
            newState.password = password
            newState.isSignUpFailed = false
            newState.isEmailNotFound = false
        }
        
        return newState
    }
}

// MARK: - Method
private extension SignUpReactor {
    func certificationButton() -> Observable<Mutation> {
        
        let startLoding = Observable.just(Mutation.setIsLoading(true))
        let emailVerify = sendVerifyUseCase.execute(email: currentState.email)
            .do(onError: { [weak self] _ in
                self?.action.onNext(.emailNotFound)
            }, onCompleted: { [weak self] in
                self?.steps.accept(GCMSStep.certificationIsRequired(email: self?.currentState.email ?? ""))
            })
            .andThen(Single.just(Mutation.setIsLoading(false)))
            .asObservable()
            .catchAndReturn(.setIsLoading(false))
        
        return .concat([startLoding, emailVerify])
    }
    
    func completeButtonDidTap() -> Observable<Mutation> {
        
        let startLoding = Observable.just(Mutation.setIsLoading(true))
        
        if currentState.password.count <= 8 {
            return .empty()
        }
        else {
            let signUp = registerUseCase.execute(req: RegisterReqeust(email: currentState.email, password: currentState.password))
                .do(onError: { [weak self] error in
                    guard let error = error as? GCMSError else { return }
                    if case GCMSError.conflict = error {
                        self?.action.onNext(.emailNotFound)
                    }
                    else if case GCMSError.forbidden = error {
                        self?.action.onNext(.signUpFailed)
                    }
    //                self?.action.onNext(.emailNotFound)
                }, onCompleted: { [weak self] in
                    self?.steps.accept(GCMSStep.clubListIsRequired)
                })
                .andThen(Single.just(Mutation.setIsLoading(false)))
                .asObservable()
                .catchAndReturn(.setIsLoading(false))
                
            return .concat([startLoding, signUp])
        }
    }
}
