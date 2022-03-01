import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import GoogleSignIn
import FirebaseCore

final class OnBoardingReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case googleSigninButtonDidTap(UIViewController)
        case googleSigninTokenReceived(String)
    }
    enum Mutation {}
    struct State {}
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension OnBoardingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .googleSigninButtonDidTap(vc):
            return googleSigninButtonDidTap(vc: vc)
        case let .googleSigninTokenReceived(token):
            return googleSigninTokenReceived(token: token)
        }
    }
}

// MARK: - Method
private extension OnBoardingReactor {
    func googleSigninButtonDidTap(vc: UIViewController) -> Observable<Mutation> {
        let config = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
        GIDSignIn.sharedInstance.signIn(with: config, presenting: vc) { user, err in
            if let err = err {
                print(err.localizedDescription)
                print("Goolge Signin Failure")
                return
            }
            
            user?.authentication.do({ auth in
                // TODO: 서버에 idToken값 보내기
            })
        }
        return .empty()
    }
    func googleSigninTokenReceived(token: String) -> Observable<Mutation> {
        return .empty()
    }
}
