import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service

final class AlarmReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
    }
    enum Mutation {
        case setAlarmList([Alarm])
    }
    struct State {
        var alarmList: [Alarm]
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State(
            alarmList: []
        )
    }
    
}

// MARK: - Mutate
extension AlarmReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        }
        return .empty()
    }
}

// MARK: - Reduce
extension AlarmReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setAlarmList(list):
            newState.alarmList = list
        }
        
        return newState
    }
}

// MARK: - Method
private extension AlarmReactor {
    func viewDidLoad() -> Observable<Mutation> {
        
        return .just(.setAlarmList([
            .init(id: 0, name: "피크닉", content: "이곳은 ⌜절망⌟이다."),
            .init(id: 1, name: "MOIZA", content: "이런 모이자"),
            .init(id: 2, name: "Dummy", content: "대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충대충")
        ]))
    }
}