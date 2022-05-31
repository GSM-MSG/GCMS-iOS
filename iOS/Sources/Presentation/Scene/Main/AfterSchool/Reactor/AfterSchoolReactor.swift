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
        case applyButtonDidTap(AfterSchoolSeason, AfterSchoolWeek, Int)
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
             steps.accept(GCMSStep.searchFilterIsRequired(closure: { [weak self] season, week, grade in
                 self?.action.onNext(.applyButtonDidTap(season, week, grade))
             }))
         case .viewDidLoad:
             return .empty()
         case let .applyButtonDidTap(season, week, grade):
             return applyButtonDidTap(season: season, week: week, grade: grade)
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

private extension AfterSchoolReactor {
    func applyButtonDidTap(season: AfterSchoolSeason, week: AfterSchoolWeek, grade: Int) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = fetchAfterSchoolListUseCase.execute(query: .init(season: season, week: week, grade: grade))
            .asObservable()
            .flatMap {
                Observable.from([
                    Mutation.setAfterSchool($0),
                    .setIsLoading(false)
                ])
            }.catchAndReturn(Mutation.setIsLoading(false))
        return .concat([start, task])
    }
}
