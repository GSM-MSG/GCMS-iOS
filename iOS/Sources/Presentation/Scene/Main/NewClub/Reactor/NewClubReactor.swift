import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import UIKit
import Service

final class NewClubReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case imageDidSelect(Data)
        case bannerDidTap
        case activityAppendButtonDidTap
        case activityDeleteDidTap(Int)
        case memberAppendButtonDidTap
        case memberDidSelected([User])
        case memberRemove(Int)
    }
    enum Mutation {
        case setImageData(Data)
        case setIsBanner(Bool)
        case removeImageData(Int)
        case appendMember([User])
        case memberRemove(Int)
    }
    struct State {
        var isBanner: Bool
        var imageData: Data?
        var activitiesData: [Data]
        var members: [User]
    }
    let initialState: State
    private let category: ClubType
    
    // MARK: - Init
    init(category: ClubType) {
        initialState = State(
            isBanner: false,
            activitiesData: [],
            members: []
        )
        self.category = category
    }
    
}

// MARK: - Mutate
extension NewClubReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .imageDidSelect(data):
            return .just(.setImageData(data))
        case .bannerDidTap:
            return .just(.setIsBanner(true))
        case .activityAppendButtonDidTap:
            return .just(.setIsBanner(false))
        case let .activityDeleteDidTap(index):
            return .just(.removeImageData(index))
        case .memberAppendButtonDidTap:
            steps.accept(GCMSStep.memberAppendIsRequired({ [weak self] users in
                self?.action.onNext(.memberDidSelected(users))
            }))
        case let .memberDidSelected(users):
            return .just(.appendMember(users))
        case let .memberRemove(index):
            return .just(.memberRemove(index))
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
            if currentState.isBanner {
                newState.imageData = data
            } else {
                if currentState.activitiesData.count > 3 {
                    steps.accept(GCMSStep.alert(title: "GCMS",
                                                message: "동아리 사진을 5개이상 추가할 수 없습니다!",
                                                style: .alert,
                                                actions: [
                                                    .init(title: "확인", style: .cancel, handler: nil)
                                                ]))
                } else {
                    newState.activitiesData.append(data)
                }
            }
        case let .setIsBanner(status):
            newState.isBanner = status
        case let .removeImageData(index):
            newState.activitiesData.remove(at: index)
        case let .appendMember(users):
            newState.members.append(contentsOf: users)
            newState.members.removeDuplicates()
        case let .memberRemove(index):
            newState.members.remove(at: index)
        }
        
        return newState
    }
}

// MARK: - Method
private extension NewClubReactor {
    
}
