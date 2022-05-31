import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import Foundation

final class SearchFilterReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    // MARK: - Reactor
    enum Action {
        case segementedSeasonCange(AfterSchoolSeason)
        case segementedWeekChange(AfterSchoolWeek)
        case segementedGradeChange(Int)
        case applyButtonDidTap
    }
    
    enum Mutation {
        case setSeason(AfterSchoolSeason)
        case setWeek(AfterSchoolWeek)
        case setGrade(Int)
    }
    
    struct State {
        var season: AfterSchoolSeason
        var week: AfterSchoolWeek
        var grade: Int
    }
    
    let initialState: State
    private let closure: ((AfterSchoolSeason, AfterSchoolWeek, Int) -> Void)
    // MARK: - Init
    init(
        closure: @escaping ((AfterSchoolSeason, AfterSchoolWeek, Int) -> Void)
    ) {
        initialState = State(
            season: AfterSchoolSeason.first,
            week: AfterSchoolWeek.monday,
            grade: 1
        )
        self.closure = closure
    }
    // MARK: - Mutate
    func mutate(action: Action) -> Observable<Mutation> {
         switch action {
         case let .segementedSeasonCange(season):
             return .just(.setSeason(season))
         case let .segementedWeekChange(week):
             return .just(.setWeek(week))
         case let .segementedGradeChange(grade):
             return .just(.setGrade(grade))
         case .applyButtonDidTap:
             closure(currentState.season, currentState.week, currentState.grade)
             steps.accept(GCMSStep.dismiss)
         }
        return .empty()
    }
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
         switch mutation {
         case let .setSeason(season):
             newState.season = season
         case let .setWeek(week):
             newState.week = week
         case let .setGrade(grade):
             newState.grade = grade
         }
        return newState
    }
    
}
