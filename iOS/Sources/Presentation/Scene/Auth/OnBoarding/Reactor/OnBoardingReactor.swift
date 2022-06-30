import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import GoogleSignIn
import FirebaseCore
import Service

final class OnBoardingReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    private let loginUseCase: LoginUseCase
    private let issueGuestTokenUseCase: IssueGuestTokenUseCase
    
    // MARK: - Reactor
    enum Action {
        case googleSigninButtonDidTap(UIViewController)
        case googleSigninCompleted
        case appleSigninCompleted
        case appleIdTokenReceived(idToken: String, code: String)
        case signinFailed(message: String?)
        case guestSigninButtonDidTap
        case termsOfServiceButtonDidTap
        case privacyButtonDidTap
    }
    enum Mutation {
        case setIsLoading(Bool)
    }
    struct State {
        var isLoading: Bool
    }
    let initialState: State
    
    // MARK: - Init
    init(
        loginUseCase: LoginUseCase,
        issueGuestTokenUseCase: IssueGuestTokenUseCase
    ) {
        initialState = State(
            isLoading: false
        )
        self.loginUseCase = loginUseCase
        self.issueGuestTokenUseCase = issueGuestTokenUseCase
    }
    
}

// MARK: - Mutate
extension OnBoardingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .googleSigninButtonDidTap(vc):
            return googleSigninButtonDidTap(vc: vc)
        case .appleSigninCompleted, .guestSigninButtonDidTap:
            return appleSigninCompleted()
        case let .signinFailed(message):
            return signinFailed(message: message)
        case .googleSigninCompleted:
            return googleSigninCompleted()
        case .termsOfServiceButtonDidTap:
            UIApplication.shared.open(URL(string: "https://shy-trust-424.notion.site/f4b4084f6235444bbcc164f7c5d86fb2") ?? .init(string: "https://www.google.com")!)
        case .privacyButtonDidTap:
            UIApplication.shared.open(URL(string: "https://shy-trust-424.notion.site/252fc57341834617b7d3c1903286c730") ?? .init(string: "https://www.google.com")!)
        case let .appleIdTokenReceived(token, code):
            return appleTokenReceived(idToken: token, code: code)
        }
        return .empty()
    }
}

extension OnBoardingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setIsLoading(loading):
            newState.isLoading = loading
        }
        return newState
    }
}

// MARK: - Method
private extension OnBoardingReactor {
    func googleSigninButtonDidTap(vc: UIViewController) -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "gsm.hs.kr 계정으로 로그인해주세요.", message: "이외 계정은 로그인되지 않습니다.", style: .alert, actions: [
            .init(title: "확인", style: .default, handler: { [weak self] _ in
                let config = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
                GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [weak self] user, err in
                    if let err = err {
                        self?.action.onNext(.signinFailed(message: err.asGCMSError?.localizedDescription))
                        return
                    }
                    
                    user?.authentication.do({ auth in
                        if let idToken = auth.idToken {
                            self?.googleSigninTokenReceived(token: idToken)
                        }
                    })
                }
            }),
            .init(title: "취소", style: .cancel)
        ]))
        
        return .empty()
    }
    func googleSigninTokenReceived(token: String) {
        UserDefaultsLocal.shared.isGuest = false
        loginUseCase.execute(idToken: token)
            .andThen(.just(()))
            .map { Action.googleSigninCompleted }
            .subscribe(with: self, onNext: { owner, action in
                owner.action.onNext(action)
            }, onError: { owner, e in
                owner.action.onNext(.signinFailed(message: e.asGCMSError?.errorDescription))
            })
            .disposed(by: disposeBag)
    }
    func googleSigninCompleted() -> Observable<Mutation> {
        steps.accept(GCMSStep.clubListIsRequired)
        return .empty()
    }
    func appleSigninCompleted() -> Observable<Mutation> {
        UserDefaultsLocal.shared.isGuest = true
        steps.accept(GCMSStep.clubListIsRequired)
        return .empty()
    }
    func signinFailed(message: String? = "로그인을 실패하였습니다") -> Observable<Mutation> {
        self.steps.accept(GCMSStep.failureAlert(title: nil, message: message))
        return .empty()
    }
    func appleTokenReceived(idToken: String, code: String) -> Observable<Mutation> {
        issueGuestTokenUseCase.execute(idToken: idToken, code: code)
            .andThen(Observable.just(()))
            .subscribe(with: self) { owner, _ in
                UserDefaultsLocal.shared.isGuest = true
                UserDefaultsLocal.shared.isApple = true
                owner.steps.accept(GCMSStep.clubListIsRequired)
            } onError: { owner, e in
                owner.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription, action: []))
            }
            .disposed(by: disposeBag)
        return .empty()
    }
}
