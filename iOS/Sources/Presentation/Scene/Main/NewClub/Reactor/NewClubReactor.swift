import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import UIKit

final class NewClubReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case imageDidSelect(Data)
    }
    enum Mutation {
        case setImageData(Data)
    }
    struct State {
        var imageData: Data?
    }
    let initialState: State
    
    // MARK: - Init
    init() {
        initialState = State()
    }
    
}

// MARK: - Mutate
extension NewClubReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .imageDidSelect(data):
            return .just(.setImageData(data))
        }
        return .empty()
    }
}

// MARK: - Reduce
extension NewClubReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setImageData(data):
            newState.imageData = data
        }
        
        return newState
    }
}

// MARK: - Method
private extension NewClubReactor {
    
}
