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
        case noticeButtonDidTap
        case deadlineButtonDidTap
        case approveButtonDidTap(User)
        case refuseDidTap(User)
    }
    enum Mutation {
        case setUser([User])
    }
    struct State {
        var acceptUser: [User]
    }
    private let id: Int
    let initialState: State
    
    // MARK: - Init
    init(
        id: Int
    ) {
        self.id = id
        initialState = State(acceptUser: [])
    }
    
}

// MARK: - Mutate
extension AcceptReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .viewDidLoad:
            return viewDidLoad()
        case .noticeButtonDidTap:
            steps.accept(GCMSStep.notificationIsRequired(id: id))
        case .deadlineButtonDidTap:
            return deadlineButtonDidTap()
        case let .approveButtonDidTap(user):
            return approveDidTap(model: user)
        case let .refuseDidTap(user):
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
        .init(id: 0, picture: "https://avatars.githubusercontent.com/u/74440939?v=4", name: "변찬우", grade: 1, class: 3, number: 4, joinedMajorClub: 1, joinedEditorialClub: [1,2], joinedFreedomClub: 1),
        .init(id: 1, picture: "https://avatars.githubusercontent.com/u/74440939?v=4", name: "변찬우", grade: 1, class: 3, number: 4, joinedMajorClub: 1, joinedEditorialClub: [1,2], joinedFreedomClub: 1),
        .init(id: 2, picture: "https://avatars.githubusercontent.com/u/74440939?v=4", name: "변찬우", grade: 1, class: 3, number: 4, joinedMajorClub: 1, joinedEditorialClub: [1,2], joinedFreedomClub: 1)
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
