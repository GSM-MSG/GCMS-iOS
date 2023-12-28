import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import Service
import Foundation

final class UpdateClubReactor: Reactor, Stepper {
    // MARK: - Properties
    var steps: PublishRelay<Step> = .init()

    private let disposeBag: DisposeBag = .init()

    // MARK: - Reactor
    enum Action {
        case bannerBinding(Mutation)
        case imageBinding([Mutation])
        // First
        case updateTitle(String)
        case updateDescription(String)
        case updateTeacher(String)
        case updateNotionLink(String)
        case updateContact(String)
        case secondNextButtonDidTap
        
        // Second
        case imageDidSelect(Data)
        case bannerDidTap
        case activityAppendButtonDidTap
        case activityDeleteDidTap(Int)
        case memberDidSelected([User])
        case memberRemove(Int)
        case updateLoading(Bool)
        case completeButtonDidTap
        case updateAgreeDidTap
    }

    enum Mutation {
        case setTitle(String)
        case setDescription(String)
        case setNotionLink(String)
        case setTeacher(String?)
        case setContact(String)
        case setImageData(Data)
        case setImageDatas([Data])
        case removeImageData(Int)
        case setIsBanner(Bool)
        case appendMember([User])
        case memberRemove(Int)
        case setClubType(ClubType)
        case setIsLoading(Bool)
    }

    struct State {
        var name: String
        var content: String
        var notionLink: String
        var contact: String
        var teacher: String?
        var bannerImg: Data?
        var activityImgs: [Data]
        var members: [User]
        var clubType: ClubType
        var isBanner: Bool
        var isLoading: Bool
    }
    let initialState: State
    private let club: Club
    private let fetchDetailClubUseCase: FetchDetailClubUseCase
    private let updateClubUseCase: UpdateClubUseCase
    private let uploadImagesUseCase: UploadImagesUseCase

    // MARK: - Init
    init(
        club: Club,
        fetchDetailClubUseCase: FetchDetailClubUseCase,
        updateClubUseCase: UpdateClubUseCase,
        uploadImagesUseCase: UploadImagesUseCase
    ) {
        initialState = State(
            name: club.name,
            content: club.content,
            notionLink: club.notionLink,
            contact: club.contact,
            activityImgs: [],
            members: club.member,
            clubType: club.type,
            isBanner: false,
            isLoading: false
        )
        self.fetchDetailClubUseCase = fetchDetailClubUseCase
        self.updateClubUseCase = updateClubUseCase
        self.uploadImagesUseCase = uploadImagesUseCase
        self.club = club

        let clubObservable = Observable.just(club)
            .share(replay: 2)

        clubObservable
            .map(\.bannerImg)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .background))
            .compactMap { URL(string: $0) }
            .flatMap { URLSession.shared.rx.data(request: URLRequest(url: $0)) }
            .map { Mutation.setImageData($0) }
            .map { Action.bannerBinding($0) }
            .bind(to: action)
            .disposed(by: disposeBag)

        clubObservable
            .map(\.activityImgs)
            .subscribe(on: SerialDispatchQueueScheduler.init(qos: .background))
            .compactMap { $0.compactMap { URL(string: $0) } }
            .flatMap { urls in
                Observable.from(
                    urls
                    .map { URLRequest(url: $0) }
                    .map { URLSession.shared.rx.data(request: $0) }
                )
                .merge()
                .toArray()
                .asObservable()
            }
            .map { Mutation.setImageDatas($0) }
            .map { Action.imageBinding([$0]) }
            .bind(to: action)
            .disposed(by: disposeBag)
    }
}

// MARK: - Mutate
extension UpdateClubReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .bannerBinding(mutation):
            return .concat([
                .just(.setIsBanner(true)),
                .just(mutation)
            ])
        case let .imageBinding(mutations):
            return .concat([
                .just(.setIsBanner(false)),
                .from(mutations)
            ])
        case let .updateTitle(title):
            return .just(.setTitle(title))
        case .completeButtonDidTap:
            return completeButtonDidTap()
        case let .updateDescription(desc):
            return .just(.setDescription(desc))
        case let .updateNotionLink(link):
            return .just(.setNotionLink(link))
        case let .updateContact(cont):
            return .just(.setContact(cont))
        case let .updateTeacher(teac):
            return .just(.setTeacher(teac))
        case .secondNextButtonDidTap:
            return secondNextButtonDidTap()
        case let .imageDidSelect(data):
            return .just(.setImageData(data))
        case .bannerDidTap:
            return .just(.setIsBanner(true))
        case .activityAppendButtonDidTap:
            return .just(.setIsBanner(false))
        case let .activityDeleteDidTap(index):
            return .just(.removeImageData(index))
        case let .memberDidSelected(users):
            return .just(.appendMember(users))
        case let .memberRemove(index):
            return .just(.memberRemove(index))
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case .updateAgreeDidTap:
            return updateClub(state: currentState)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension UpdateClubReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setTitle(title):
            newState.name = title
        case let .setDescription(desc):
            newState.content = desc
        case let .setNotionLink(link):
            newState.notionLink = link
        case let .setContact(cont):
            newState.contact = cont
        case let .setTeacher(teac):
            newState.teacher = teac
        case let .setImageData(data):
            if currentState.isBanner {
                newState.bannerImg = data
            } else {
                if currentState.activityImgs.count > 3 {
                    steps.accept(
                        GCMSStep.alert(
                            title: "GCMS",
                            message: "동아리 사진을 5개이상 추가할 수 없습니다!",
                            style: .alert,
                            actions: [
                                .init(title: "확인", style: .cancel, handler: nil)
                            ]
                        )
                    )
                } else {
                    newState.activityImgs.append(data)
                }
            }
        case let .setImageDatas(datas):
            for data in datas {
                if currentState.activityImgs.count > 3 {
                    steps.accept(GCMSStep.alert(title: "GCMS",
                                                message: "동아리 사진을 5개이상 추가할 수 없습니다!",
                                                style: .alert,
                                                actions: [
                                                    .init(title: "확인", style: .cancel, handler: nil)
                                                ]))
                } else {
                    newState.activityImgs.append(data)
                }
            }
        case let .setIsBanner(status):
            newState.isBanner = status
        case let .removeImageData(index):
            _ = newState.activityImgs.remove(at: index)
        case let .setClubType(clubType):
            newState.clubType = clubType
        case let .appendMember(users):
            newState.members.append(contentsOf: users)
            newState.members.removeDuplicates()
        case let .memberRemove(index):
            newState.members.remove(at: index)
        case let .setIsLoading(load):
            newState.isLoading = load
        }

        return newState
    }
}

// MARK: - Method
private extension UpdateClubReactor {
    func secondNextButtonDidTap() -> Observable<Mutation> {
        var errorMessage = ""
        if currentState.name.isBlank() {
            errorMessage = "동아리 이름을 입력해주세요!"
        }
        else if currentState.content.isBlank() || currentState.content.trimmingCharacters(in: .whitespaces).hasPrefix("\n") || currentState.content == "동아리 설명을 입력해주세요." {
            errorMessage = "동아리 설명을 입력해주세요!"
        }
        else if currentState.contact.isBlank() {
            errorMessage = "연락처를 입력해주세요!"
        }
        else if currentState.notionLink.isBlank() || !currentState.notionLink.hasPrefix("https://") {
            errorMessage = "노션 링크를 정확히 입력해주세요!"
        }
        else {
            steps.accept(GCMSStep.secondUpdateClubIsRequired(reactor: self))
        }
        if !errorMessage.isEmpty {
            steps.accept(GCMSStep.failureAlert(title: errorMessage, message: nil))
        }
        return .empty()
    }
    func updateClub(state: State) -> Observable<Mutation> {
        let startLoadingObservable = Observable.just(Mutation.setIsLoading(true))
        let updateObservable = Observable.zip(
            uploadImagesUseCase.execute(images: [state.bannerImg ?? Data()]).compactMap(\.first).asObservable(),
            uploadImagesUseCase.execute(images: state.activityImgs).asObservable()
        )
            .withUnretained(self)
            .flatMap { owner, urls -> Observable<Mutation> in
                let completable = owner.updateClubUseCase.execute(
                    clubID: owner.club.clubID,
                    req: .init(
                        name: state.name,
                        content: state.content,
                        bannerImg: urls.0,
                        contact: state.contact,
                        notionLink: state.notionLink,
                        teacher: state.teacher,
                        activityImgs: urls.1,
                        member: state.members.map(\.uuid)
                    )
                )
                return completable
                    .do(afterCompleted: {
                        owner.steps.accept(GCMSStep.popToRoot)
                    })
                    .andThen(Observable.just(Mutation.setIsLoading(false)))
                    .catch { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.localizedDescription))
                        return .just(.setIsLoading(false))
                    }
            }
            .catch { e in
                self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.localizedDescription))
                return .just(.setIsLoading(false))
            }
        return .concat([startLoadingObservable, updateObservable])
    }
    func completeButtonDidTap() -> Observable<Mutation> {
        guard currentState.bannerImg != nil else {
            steps.accept(GCMSStep.failureAlert(title: "동아리 배너 이미지를 넣어주세요!", message: nil))
            return .empty()
        }
        steps.accept(GCMSStep.alert(title: "정말로 완료하시겠습니까?", message: nil, style: .alert, actions: [
            .init(title: "예", style: .default, handler: { [weak self] _ in
                self?.action.onNext(.updateAgreeDidTap)
            }),
            .init(title: "아니요", style: .default, handler: nil)
        ]))
        return .empty()
    }
}
