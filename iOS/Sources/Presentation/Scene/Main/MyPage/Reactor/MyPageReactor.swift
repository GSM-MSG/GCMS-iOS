import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class MyPageReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case clubManageButtonDidTap
    }
    enum Mutation {
        case setEditorialClubList([ClubList])
        case setMajorClub(ClubList)
        case setFreedomClub(ClubList)
    }
    struct State {
        var editorialClubList: [ClubList]
        var majorClub: ClubList?
        var freedomClub: ClubList?
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            editorialClubList: []
        )
    }
    
}

// MARK: - Mutate
extension MyPageReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case .clubManageButtonDidTap:
            steps.accept(GCMSStep.clubManagementIsRequired)
//            return clubManageButtonDidTap()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension MyPageReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setEditorialClubList(list):
            newState.editorialClubList = list
        case let .setMajorClub(club):
            newState.majorClub = club
        case let .setFreedomClub(club):
            newState.freedomClub = club
        }
        
        return newState
    }
}

// MARK: - Method
private extension MyPageReactor {
    func viewDidLoad() -> Observable<Mutation> {
        return .concat([
            .just(.setEditorialClubList([
                .init(id: 0, bannerUrl: "https://avatars.githubusercontent.com/u/74440939?v=4", title: "asdf", type: .editorial),
                .init(id: 1, bannerUrl: "https://avatars.githubusercontent.com/u/67373938?v=4", title: "대충 타이틀", type: .editorial),
                .init(id: 2, bannerUrl: "https://avatars.githubusercontent.com/u/74440939?v=4", title: "ㅁㄴㅇ", type: .editorial),
                .init(id: 3, bannerUrl: "https://avatars.githubusercontent.com/u/74440939?v=4", title: "ㅍ", type: .editorial)
            ])),
            .just(.setMajorClub(.init(id: 2, bannerUrl: "https://avatars.githubusercontent.com/u/80966659?v=4", title: "MAJOR", type: .major))),
            .just(.setFreedomClub(.init(id: 3, bannerUrl: "https://camo.githubusercontent.com/9ed64b042a76b8a97016e877cbaee0d6df224a148034afef658d841cf0cd1791/68747470733a2f2f63756c746f667468657061727479706172726f742e636f6d2f706172726f74732f68642f6c6170746f705f706172726f742e676966", title: "FREEDOM", type: .freedom)))
        ])
    }
    
}
