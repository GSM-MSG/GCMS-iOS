import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import UIKit

final class DetailClubReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()
    
    private let disposeBag: DisposeBag = .init()
    
    // MARK: - Reactor
    enum Action {
        case viewDidLoad
        case updateLoading(Bool)
        case statusButtonDidTap
        case linkButtonDidTap
    }
    enum Mutation {
        case setClub(Club)
        case setIsLoading(Bool)
    }
    struct State {
        var clubDetail: Club?
        var isLoading: Bool
    }
    let initialState: State
    private let query: ClubRequestQuery
    private let deleteClubUseCase: DeleteClubUseCase
    private let fetchDetailClubUseCase: FetchDetailClubUseCase
    private let fetchGuestDetailClubUseCase: FetchGuestDeatilClubUseCase
    private let clubExitUseCase: ClubExitUseCase
    private let clubApplyUseCase: ClubApplyUseCase
    private let clubCancelUseCase: ClubCancelUseCase
    private let clubOpenUseCase: ClubOpenUseCase
    private let clubCloseUseCase: ClubCloseUseCase
    
    // MARK: - Init
    init(
        query: ClubRequestQuery,
        deleteClubUseCase: DeleteClubUseCase,
        fetchDetailClubUseCase: FetchDetailClubUseCase,
        fetchGuestDetailClubUseCase: FetchGuestDeatilClubUseCase,
        clubExitUseCase: ClubExitUseCase,
        clubApplyUseCase: ClubApplyUseCase,
        clubCancelUseCase: ClubCancelUseCase,
        clubOpenUseCase: ClubOpenUseCase,
        clubCloseUseCase: ClubCloseUseCase
    ) {
        initialState = State(
            isLoading: false
        )
        self.query = query
        self.deleteClubUseCase = deleteClubUseCase
        self.fetchDetailClubUseCase = fetchDetailClubUseCase
        self.fetchGuestDetailClubUseCase = fetchGuestDetailClubUseCase
        self.clubExitUseCase = clubExitUseCase
        self.clubApplyUseCase = clubApplyUseCase
        self.clubCancelUseCase = clubCancelUseCase
        self.clubOpenUseCase = clubOpenUseCase
        self.clubCloseUseCase = clubCloseUseCase
    }
    
}

// MARK: - Mutate
extension DetailClubReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return viewDidLoad()
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .statusButtonDidTap:
            return statusButtonDidTap()
        case .linkButtonDidTap:
            UIApplication.shared.open(URL(string: currentState.clubDetail?.relatedLink?.url ?? "https://www.google.com")!)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension DetailClubReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setClub(club):
            newState.clubDetail = club
        case let .setIsLoading(load):
            newState.isLoading = load
        }
        
        return newState
    }
}

// MARK: - Method
private extension DetailClubReactor {
    func viewDidLoad() -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        if UserDefaultsLocal.shared.isApple {
            let task = fetchGuestDetailClubUseCase.execute(query: query)
                .asObservable()
                .flatMap { Observable.from([Mutation.setClub($0), .setIsLoading(false)]) }
                .catchAndReturn(.setIsLoading(false))
            return .concat([start, task])
        } else {
            let task = fetchDetailClubUseCase.execute(query: query)
                .asObservable()
                .flatMap { Observable.from([Mutation.setClub($0), .setIsLoading(false)]) }
                .catchAndReturn(.setIsLoading(false))
            
            return .concat([start, task])            
        }
    }
    func statusButtonDidTap() -> Observable<Mutation> {
        let isHead = (currentState.clubDetail?.scope ?? .member) == .head
        let title = isHead ? "동아리 절명하기" : "동아리 탈퇴하기"
        steps.accept(GCMSStep.alert(title: nil, message: nil, style: .actionSheet, actions: [
            .init(title: "동아리 멤버 관리", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.steps.accept(GCMSStep.clubStatusIsRequired(query: self.query , isHead: isHead))
            }),
            .init(title: "동아리 수정하기", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                guard let club = self.currentState.clubDetail else { return }
                self.steps.accept(GCMSStep.firstUpdateClubIsRequired(club: club))
            }),
            .init(title: title, style: .destructive, handler: { [weak self] _ in
                
            }),
            .init(title: "취소", style: .cancel, handler: nil)
        ]))
        return .empty()
    }
}
