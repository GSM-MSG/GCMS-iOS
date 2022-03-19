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
        case segmentDidTap(ClubType)
        case myPageButtonDidTap
        case alarmButtonDidTap
        case updateLoading(Bool)
    }
    enum Mutation {
        case setClubList([ClubList])
        case setIsLoading(Bool)
        case setClubType(ClubType)
    }
    struct State {
        var clubList: [ClubListSection]
        var clubType: ClubType
        var isLoading: Bool
    }
    let initialState: State
    
    // MARK: - Init
    init(
        
    ) {
        
        initialState = State(
            clubList: [],
            clubType: .major,
            isLoading: false
        )
    }
    
}

// MARK: - Mutate
extension HomeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case .myPageButtonDidTap:
            steps.accept(GCMSStep.myPageIsRequired)
        case .alarmButtonDidTap:
            steps.accept(GCMSStep.alarmListIsRequired)
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case let .segmentDidTap(type):
            return .just(.setClubType(type))
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
        case let .setIsLoading(load):
            newState.isLoading = load
        case let .setClubType(type):
            newState.clubType = type
        }
        
        return newState
    }
}

// MARK: - Method
private extension HomeReactor {
    func viewDidLoad() -> Observable<Mutation> {
        
        return .just(.setClubList([
            .init(bannerUrl: "https://avatars.githubusercontent.com/u/74440939?s=48&v=4", title: "대충 타이틀", type: .freedom),
            .init(bannerUrl: "https://avatars.githubusercontent.com/u/89921023?s=64&v=4", title: "ㅁㄴㅇㄹㅁㄴㅇㅁㄴㅇ", type: .major),
            .init(bannerUrl: "https://i.ytimg.com/vi/Kkc8aJct6qQ/hq720.jpg?sqp=-oaymwEXCNAFEJQDSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLDIZTIWGHrxuF6NijuyVWUsKHi1fw", title: "ㅁㄴ", type: .editorial),
            .init(bannerUrl: "https://avatars.githubusercontent.com/u/74440939?s=48&v=4", title: "대충 타이틀", type: .freedom),
            .init(bannerUrl: "https://avatars.githubusercontent.com/u/89921023?s=64&v=4", title: "ㅁㄴㅇㄹㅁㄴㅇㅁㄴㅇ", type: .major),
            .init(bannerUrl: "https://user-images.githubusercontent.com/74440939/156344036-247e71ef-e020-40bb-bc4d-9553f0636e30.png", title: "ㄴㅁㅇㅁㄴㄹ", type: .editorial)
        ]))
    }
}
