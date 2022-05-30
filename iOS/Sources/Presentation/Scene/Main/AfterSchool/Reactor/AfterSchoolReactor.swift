import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import Foundation

final class AfterSchoolReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case searchFilterButtonDidTap
    }
    
    enum Mutation {
        case setIsLoading(Bool)
        case setAfterSchool([AfterSchool])
    }
    
    struct State {
        var isLoading: Bool
        var afterSchool: [AfterSchool]
    }
    
    let initialState: State
    private let fetchAfterSchoolListUseCase: FetchAfterSchoolListUseCase
    
    // MARK: - Init
    init(
        fetchAfterSchoolListUseCase: FetchAfterSchoolListUseCase
    ) {
        initialState = State(
            isLoading: false,
            afterSchool: []
        )
        self.fetchAfterSchoolListUseCase = fetchAfterSchoolListUseCase
    }
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
         switch action {
         case .searchFilterButtonDidTap:
             steps.accept(GCMSStep.searchFilterIsRequired)
         case .viewDidLoad:
             return .empty()
         }
        return .empty()
    }
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
         switch mutation {
         case let .setIsLoading(load):
             newState.isLoading = load
         case let .setAfterSchool(afterSchool):
             newState.afterSchool = afterSchool
         }
        return newState
    }
    
}
