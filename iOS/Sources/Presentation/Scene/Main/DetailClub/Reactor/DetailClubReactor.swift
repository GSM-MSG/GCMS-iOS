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
        case viewWillAppear
        case updateLoading(Bool)
        case statusButtonDidTap
        case linkButtonDidTap
        case bottomButtonDidTap
        case updateClub(Club?)
    }
    enum Mutation {
        case setClub(Club?)
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
        case .viewWillAppear:
            return viewDidLoad()
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .statusButtonDidTap:
            return statusButtonDidTap()
        case .linkButtonDidTap:
            UIApplication.shared.open(URL(string: currentState.clubDetail?.notionLink ?? "https://www.google.com") ?? .init(string: "https://www.google.com")!)
        case .bottomButtonDidTap:
            return bottomButtonDidTap()
        case let .updateClub(club):
            return .just(.setClub(club))
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
        let task: Single<Club>
        task = UserDefaultsLocal.shared.isGuest
        ? fetchGuestDetailClubUseCase.execute(query: query)
        : fetchDetailClubUseCase.execute(query: query)
        
        let res = task
            .asObservable()
            .flatMap { Observable.from([Mutation.setClub($0), .setIsLoading(false)]) }
            .catch { [weak self] e in
                self?.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription, action: []))
                return .just(.setIsLoading(false))
            }
        
        return .concat([start, res])
    }
    func bottomButtonDidTap() -> Observable<Mutation> {
        guard let club = currentState.clubDetail else { return .empty() }
        switch club.scope {
        case .head:
            return club.isOpen ? clubClose() : clubOpen()
        case .member:
            break
        case .`default`:
            if club.isOpen {
                if club.isApplied {
                    return clubCancel()
                } else {
                    return clubApply()
                }
            } else {
                break
            }
        case .other:
            break
        }
        return .empty()
    }
    func statusButtonDidTap() -> Observable<Mutation> {
        let isHead = (currentState.clubDetail?.scope ?? .member) == .head
        let title = isHead ? "????????? ????????????" : "????????? ????????????"
        var actions: [UIAlertAction] = []
        actions.append(.init(title: "????????? ?????? ??????", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.steps.accept(GCMSStep.clubStatusIsRequired(query: self.query , isHead: isHead, isOpened: self.currentState.clubDetail?.isOpen ?? false))
        }))
        if isHead {
            actions.append(.init(title: "????????? ????????????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                guard let club = self.currentState.clubDetail else { return }
                self.steps.accept(GCMSStep.firstUpdateClubIsRequired(club: club))
            }))
        }
        actions.append(.init(title: title, style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            if isHead {
                self.clubDelete()
            } else {
                self.clubExit()
            }
        }))
        actions.append(.init(title: "??????", style: .cancel, handler: nil))
        let style: UIAlertController.Style = UIDevice.current.userInterfaceIdiom == .phone ? .actionSheet : .alert
        steps.accept(GCMSStep.alert(title: nil, message: nil, style: style, actions: actions))
        return .empty()
    }
    func clubDelete() {
        self.steps.accept(GCMSStep.alert(title: "????????? ???????????? ?????????????????????????", message: "??? ????????? ????????? ??? ????????????.", style: .alert, actions: [
            .init(title: "??????", style: .destructive, handler: { _ in
                self.deleteClubUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.popToRoot)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??? ??? ?????? ????????? ??????????????????.", message: e.asGCMSError?.errorDescription, action: [
                            .init(title: "??????", style: .default)
                        ]))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
    }
    func clubExit() {
        self.steps.accept(GCMSStep.alert(title: "????????? ???????????? ?????????????????????????", message: "??? ????????? ????????? ??? ????????????.", style: .alert, actions: [
            .init(title: "??????", style: .destructive, handler: { _ in
                self.clubExitUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.popToRoot)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??? ??? ?????? ????????? ??????????????????.", message: e.asGCMSError?.errorDescription, action: [
                            .init(title: "??????", style: .default)
                        ]))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
    }
    func clubClose() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "????????????", message: "????????? ????????? ?????????????????????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubCloseUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "??????", message: "????????? ????????? ?????????????????????.", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        self.action.onNext(.updateClub(self.currentState.clubDetail?.copyForChange(isOpen: false)))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
    func clubOpen() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "????????????", message: "????????? ????????? ????????????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubOpenUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "??????", message: "????????? ????????? ???????????????.", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        self.action.onNext(.updateClub(self.currentState.clubDetail?.copyForChange(isOpen: true)))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
    func clubApply() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "????????????", message: "?????? '\(query.q)' ???????????? ???????????? ??????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubApplyUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "??????", message: "????????? ????????? ?????????????????????.", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        self.action.onNext(.updateClub(self.currentState.clubDetail?.copyForChange(isApplied: true)))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
    func clubCancel() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "?????? ????????????", message: "?????? ????????? ??????????????????????", style: .alert, actions: [
            .init(title: "??????", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubCancelUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "??????", message: "????????? ????????? ?????????????????????.", style: .alert, actions: [.init(title: "??????", style: .default)]))
                        self.action.onNext(.updateClub(self.currentState.clubDetail?.copyForChange(isApplied: false)))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "??????", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "??????", style: .cancel)
        ]))
        return .empty()
    }
}
