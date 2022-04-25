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
    let initialState: State
    private let closure: (([User]) -> Void)
    private let clubType: ClubType
    
    // MARK: - Init
    init(
        closure: @escaping (([User]) -> Void),
        clubType: ClubType
    ) {
        initialState = State(   
            query: "",
            users: [],
            addedUsers: [],
            isLoading: false
        )
        self.closure = closure
        self.clubType = clubType
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
            .dummy,
            .dummy
        ].filter { $0.name.contains(query) }
        return .concat([
            .just(.setQuery(query)),
            .just(.setUsers(users))
        ])
    }
}
