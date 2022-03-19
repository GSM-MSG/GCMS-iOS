import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import UIKit

final class AcceptReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case deadlineButtonDidTap
        case approveButtonDidTap(User)
        case refuseButtonDidTap(User)
    }
    enum Mutation {
        case setUser([User])
    }
    struct State {
        var acceptUser: [User]
    }
    private let query: ClubRequestComponent
    let initialState: State
    
    // MARK: - Init
    init(
        query: ClubRequestComponent
    ) {
        self.query = query
        initialState = State(acceptUser: [])
    }
    
}

// MARK: - Mutate
extension AcceptReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .viewDidLoad:
            return viewDidLoad()
        case .deadlineButtonDidTap:
            return deadlineButtonDidTap()
        case let .approveButtonDidTap(user):
            return approveDidTap(model: user)
        case let .refuseButtonDidTap(user):
            return refuseDidTap(model: user)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension AcceptReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        case let .setUser(user):
            newState.acceptUser = user
        }
        
        return newState
    }
}

// MARK: - Method
private extension AcceptReactor {
    
    func viewDidLoad() -> Observable<Mutation> {
        return .just(.setUser([
            
        ]))
    }
    
    func refuseDidTap(model: User) -> Observable<Mutation>{
        let cancelButton = UIAlertAction(title: "취소", style: .destructive, handler: { [weak self] _ in
            
        })
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        steps.accept(GCMSStep.alert(title: nil, message: "\(model.name)님의 가입을 거절하시겠습니까?", style: .alert, actions: [cancelButton, okButton]))
        return .empty()
    }
    
    func approveDidTap(model: User) -> Observable<Mutation>{
        let cancelButton = UIAlertAction(title: "취소", style: .destructive, handler: { [weak self] _ in
            
        })
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        steps.accept(GCMSStep.alert(title: nil, message: "\(model.name)님의 가입을 승인하시겠습니까?", style: .alert, actions: [cancelButton, okButton]))
        return .empty()
    }
    
    func deadlineButtonDidTap() -> Observable<Mutation>{
        let cancelButton = UIAlertAction(title: "취소", style: .destructive, handler: { [weak self] _ in
            
        })
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        steps.accept(GCMSStep.alert(title: nil, message: "동아리 신청을 마감하시겠습니까?", style: .alert, actions: [cancelButton, okButton]))
        return .empty()
    }
    
}
