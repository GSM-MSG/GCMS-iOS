import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class HomeReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case setClubList([ClubList])
    }
    struct State {
        var clubList: [ClubListSection]
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            clubList: []
        )
    }
    
}

// MARK: - Mutate
extension HomeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension HomeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setClubList(lists):
            newState.clubList = [ClubListSection(header: "", items: lists)]
        }
        
        return newState
    }
}

// MARK: - Method
private extension HomeReactor {
    func viewDidLoad() -> Observable<Mutation> {
        
        return .just(.setClubList([
            .init(bannerUrl: "https://avatars.githubusercontent.com/u/74440939?s=48&v=4", title: "대충 타이틀", type: .major),
            .init(bannerUrl: "https://avatars.githubusercontent.com/u/89921023?s=64&v=4", title: "ㅁㄴㅇㄹㅁㄴㅇㅁㄴㅇ", type: .autonomy)
        ]))
    }
}
