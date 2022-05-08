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
    
    // MARK: - Reactor
    enum Action {
        case googleSigninButtonDidTap(UIViewController)
        case appleSigninCompleted
        case appleSigninFailed
    }
    enum Mutation {
        case setIsLoading(Bool)
    }
    struct State {
        var isLoading: Bool
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            isLoading: false
        )
    }
    
}

// MARK: - Mutate
extension OnBoardingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .googleSigninButtonDidTap(vc):
            return googleSigninButtonDidTap(vc: vc)
        case .appleSigninCompleted:
            return appleSigninCompleted()
        case .appleSigninFailed:
            return appleSigninFailed()
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
        let config = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { [weak self] user, err in
            if let err = err {
                print(err.localizedDescription)
                print("Goolge Signin Failure")
                return
            }
            
            user?.authentication.do({ auth in
                if let idToken = auth.idToken {
                    self?.googleSigninTokenReceived(token: idToken)
                }
            })
        }
        return .empty()
    }
    func googleSigninTokenReceived(token: String) {
        UserDefaultsLocal.shared.isApple = false
        // TODO: 서버에 idToken값 보내기
    }
    func appleSigninCompleted() -> Observable<Mutation> {
        UserDefaultsLocal.shared.isApple = true
        steps.accept(GCMSStep.clubListIsRequired)
        return .empty()
    }
    func appleSigninFailed() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.failureAlert(title: nil, message: "Apple로 로그인이 실패하였습니다", action: nil))
        return .empty()
    }
}
