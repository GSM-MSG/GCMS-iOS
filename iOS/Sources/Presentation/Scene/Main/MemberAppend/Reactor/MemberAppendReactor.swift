import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class MemberAppendReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case updateQuery(String)
        case userDidTap(User)
        case removeAddedUser(Int)
        case completeButtonDidTap
        case cancelButtonDidTap
        case updateLoading(Bool)
    }
    enum Mutation {
        case setQuery(String)
        case setUsers([User])
        case appendAddedUser(User)
        case removeAddedUser(Int)
        case setIsLoading(Bool)
    }
    struct State {
        var query: String
        var users: [User]
        var addedUsers: [User]
        var isLoading: Bool
    }
    private let closure: (([User]) -> Void)
    let initialState: State
    private let searchUserUseCase: SearchUserUseCase
    
    // MARK: - Init
    init(
        closure: @escaping (([User]) -> Void),
        searchUserUseCase: SearchUserUseCase
    ) {
        initialState = State(   
            query: "",
            users: [],
            addedUsers: [],
            isLoading: false
        )
        self.searchUserUseCase = searchUserUseCase
        self.closure = closure
    }
    
}

// MARK: - Mutate
extension MemberAppendReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateQuery(q):
            return updateQuery(query: q)
        case let .userDidTap(user):
            return .just(.appendAddedUser(user))
        case let .removeAddedUser(index):
            return .just(.removeAddedUser(index))
        case .completeButtonDidTap:
            closure(currentState.addedUsers)
            steps.accept(GCMSStep.dismiss)
        case .cancelButtonDidTap:
            steps.accept(GCMSStep.dismiss)
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension MemberAppendReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setQuery(q):
            newState.query = q
        case let .setUsers(users):
            newState.users = users
        case let .appendAddedUser(user):
            newState.addedUsers.append(user)
            newState.addedUsers.removeDuplicates()
        case let .removeAddedUser(index):
            newState.addedUsers.remove(at: index)
        case let .setIsLoading(load):
            newState.isLoading = load
        }
        return newState
    }
}

// MARK: - Method
private extension MemberAppendReactor {
    func updateQuery(query: String) -> Observable<Mutation> {
        let users: [User] = [
            .init(id: 0, picture: "https://camo.githubusercontent.com/9ed64b042a76b8a97016e877cbaee0d6df224a148034afef658d841cf0cd1791/68747470733a2f2f63756c746f667468657061727479706172726f742e636f6d2f706172726f74732f68642f6c6170746f705f706172726f742e676966", name: "김김김", grade: 2, class: 3, number: 1),
            .init(id: 1, picture: "https://camo.githubusercontent.com/9ed64b042a76b8a97016e877cbaee0d6df224a148034afef658d841cf0cd1791/68747470733a2f2f63756c746f667468657061727479706172726f742e636f6d2f706172726f74732f68642f6c6170746f705f706172726f742e676966", name: "민민민", grade: 2, class: 3, number: 1),
            .init(id: 2, picture: "https://camo.githubusercontent.com/9ed64b042a76b8a97016e877cbaee0d6df224a148034afef658d841cf0cd1791/68747470733a2f2f63756c746f667468657061727479706172726f742e636f6d2f706172726f74732f68642f6c6170746f705f706172726f742e676966", name: "곽곽곽", grade: 2, class: 3, number: 1),
            .init(id: 3, picture: "https://camo.githubusercontent.com/9ed64b042a76b8a97016e877cbaee0d6df224a148034afef658d841cf0cd1791/68747470733a2f2f63756c746f667468657061727479706172726f742e636f6d2f706172726f74732f68642f6c6170746f705f706172726f742e676966", name: "백백백", grade: 2, class: 3, number: 1)
        ].filter { $0.name.contains(query) }
        return .concat([
            .just(.setQuery(query)),
            .just(.setUsers(users))
        ])
    }
}
