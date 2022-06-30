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
            .catchAndReturn(.setIsLoading(false))
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
        let title = isHead ? "동아리 삭제하기" : "동아리 탈퇴하기"
        var actions: [UIAlertAction] = []
        actions.append(.init(title: "동아리 멤버 관리", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.steps.accept(GCMSStep.clubStatusIsRequired(query: self.query , isHead: isHead, isOpened: self.currentState.clubDetail?.isOpen ?? false))
        }))
        if isHead {
            actions.append(.init(title: "동아리 수정하기", style: .default, handler: { [weak self] _ in
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
        actions.append(.init(title: "취소", style: .cancel, handler: nil))
        let style: UIAlertController.Style = UIDevice.current.userInterfaceIdiom == .phone ? .actionSheet : .alert
        steps.accept(GCMSStep.alert(title: nil, message: nil, style: style, actions: actions))
        return .empty()
    }
    func clubDelete() {
        self.steps.accept(GCMSStep.alert(title: "정말로 동아리를 삭제하시겠습니까?", message: "이 선택은 되돌릴 수 없습니다.", style: .alert, actions: [
            .init(title: "확인", style: .destructive, handler: { _ in
                self.deleteClubUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.popToRoot)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "알 수 없는 오류가 일어났습니다.", message: e.asGCMSError?.errorDescription, action: [
                            .init(title: "확인", style: .default)
                        ]))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
    }
    func clubExit() {
        self.steps.accept(GCMSStep.alert(title: "정말로 동아리를 탈퇴하시겠습니까?", message: "이 선택은 되돌릴 수 없습니다.", style: .alert, actions: [
            .init(title: "확인", style: .destructive, handler: { _ in
                self.clubExitUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe(onNext: { _ in
                        self.steps.accept(GCMSStep.popToRoot)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "알 수 없는 오류가 일어났습니다.", message: e.asGCMSError?.errorDescription, action: [
                            .init(title: "확인", style: .default)
                        ]))
                    })
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
    }
    func clubClose() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "마감하기", message: "동아리 신청을 마감하시겠습니까?", style: .alert, actions: [
            .init(title: "마감", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubCloseUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "성공", message: "동아리 신청이 마감되었습니다.", style: .alert, actions: [.init(title: "확인", style: .default)]))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func clubOpen() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "신청받기", message: "동아리 신청을 받겠습니까?", style: .alert, actions: [
            .init(title: "받기", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubOpenUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "성공", message: "동아리 신청이 열렸습니다.", style: .alert, actions: [.init(title: "확인", style: .default)]))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func clubApply() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "신청하기", message: "정말 '\(query.q)' 동아리에 가입하실 건가요?", style: .alert, actions: [
            .init(title: "신청", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubApplyUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "성공", message: "동아리 신청이 성공하였습니다.", style: .alert, actions: [.init(title: "확인", style: .default)]))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
    func clubCancel() -> Observable<Mutation> {
        self.steps.accept(GCMSStep.alert(title: "신청 취소하기", message: "정말 신청을 취소하실건가요?", style: .alert, actions: [
            .init(title: "신청", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.clubCancelUseCase.execute(query: self.query)
                    .andThen(Observable.just(()))
                    .subscribe { _ in
                        self.steps.accept(GCMSStep.alert(title: "성공", message: "동아리 신청이 취소되었습니다.", style: .alert, actions: [.init(title: "확인", style: .default)]))
                    } onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    }
                    .disposed(by: self.disposeBag)
            }),
            .init(title: "취소", style: .cancel)
        ]))
        return .empty()
    }
}
