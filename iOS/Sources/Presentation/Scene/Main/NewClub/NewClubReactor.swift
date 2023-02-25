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
        // First
        case clubTypeDidTap(ClubType)

        // Second
        case updateName(String)
        case updateContent(String)
        case updateNotionLink(String)
        case updateTeacher(String?)
        case updateContact(String)
        case secondNextButtonDidTap

        // Third
        case imageDidSelect(Data)
        case bannerDidTap
        case activityImgsAppendButtonDidTap
        case activityImgsDeleteDidTap(Int)
        case memberAppendButtonDidTap
        case memberDidSelected([User])
        case memberRemove(Int)
        case updateLoading(Bool)
        case completeButtonDidTap

        // etc
        case createNewClub(state: State)
    }
    enum Mutation {
        case setName(String)
        case setContent(String)
        case setNotionLink(String)
        case setTeacher(String?)
        case setContact(String)
        case setImageData(Data)
        case setIsBanner(Bool)
        case removeImageData(Int)
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
    private let createNewClubUseCase: CreateNewClubUseCase
    private let uploadImagesUseCase: UploadImagesUseCase

    // MARK: - Init
    init(
        createNewClubUseCase: CreateNewClubUseCase,
        uploadImagesUseCase: UploadImagesUseCase
    ) {
        initialState = State(
            name: "",
            content: "",
            notionLink: "",
            contact: "",
            teacher: "",
            bannerImg: .empty,
            activityImgs: [],
            members: [],
            clubType: .major,
            isBanner: false,
            isLoading: false
        )
        self.createNewClubUseCase = createNewClubUseCase
        self.uploadImagesUseCase = uploadImagesUseCase
    }

}

// MARK: - Mutate
extension NewClubReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updateName(name):
            return .just(.setName(name))
        case .completeButtonDidTap:
            return completeButtonDidTap()
        case let .updateContent(content):
            return .just(.setContent(content))
        case let .updateNotionLink(link):
            return .just(.setNotionLink(link))
        case let .updateContact(cont):
            return .just(.setContact(cont))
        case let .updateTeacher(teac):
            return .just(.setTeacher(teac))
        case .secondNextButtonDidTap:
            return secondNextButtonDidTap()
        case let .clubTypeDidTap(type):
            steps.accept(GCMSStep.secondNewClubIsRequired(reactor: self))
            return .just(.setClubType(type))
        case let .imageDidSelect(data):
            return .just(.setImageData(data))
        case .bannerDidTap:
            return .just(.setIsBanner(true))
        case .activityImgsAppendButtonDidTap:
            return .just(.setIsBanner(false))
        case let .activityImgsDeleteDidTap(index):
            return .just(.removeImageData(index))
        case .memberAppendButtonDidTap:
            steps.accept(GCMSStep.memberAppendIsRequired(closure: { [weak self] users in
                self?.action.onNext(.memberDidSelected(users))
            }, clubType: currentState.clubType))
        case let .memberDidSelected(users):
            return .just(.appendMember(users))
        case let .memberRemove(index):
            return .just(.memberRemove(index))
        case let .updateLoading(load):
            return .just(.setIsLoading(load))
        case let .createNewClub(state):
            return createNewClub(state: state)
        }
        return .empty()
    }
}

// MARK: - Reduce
extension NewClubReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case let .setName(name):
            newState.name = name
        case let .setContent(content):
            newState.content = content
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
            newState.activityImgs.remove(at: index)
        case let .appendMember(users):
            newState.members.append(contentsOf: users)
            newState.members.removeDuplicates()
        case let .memberRemove(index):
            newState.members.remove(at: index)
        case let .setClubType(type):
            newState.clubType = type
        case let .setIsLoading(load):
            newState.isLoading = load
        }

        return newState
    }
}

// MARK: - Method
private extension NewClubReactor {
    func secondNextButtonDidTap() -> Observable<Mutation> {
        var errorMessage = ""
        if currentState.name.isEmpty {
            errorMessage = "동아리 이름을 입력해주세요!"
        } else if currentState.content.isEmpty || currentState.content == "동아리 설명을 입력해주세요." {
            errorMessage = "동아리 설명을 입력해주세요!"
        } else if currentState.contact.isEmpty {
            errorMessage = "연락처를 입력해주세요!"
        } else if currentState.notionLink.isEmpty || !currentState.notionLink.hasPrefix("https://") {
            errorMessage = "노션 링크를 정확히 입력해주세요!"
        } else {
            steps.accept(GCMSStep.thirdNewClubIsRequired(reactor: self))
        }
        if !errorMessage.isEmpty {
            steps.accept(GCMSStep.failureAlert(title: errorMessage, message: nil))
        }
        return .empty()
    }
    func completeButtonDidTap() -> Observable<Mutation> {
        guard currentState.bannerImg != nil  else {
            steps.accept(GCMSStep.failureAlert(title: "동아리 배너 이미지를 넣어주세요!", message: nil))
            return .empty()
        }
        steps.accept(GCMSStep.alert(title: "정말로 완료하시겠습니까?", message: nil, style: .alert, actions: [
            .init(title: "예", style: .default, handler: { [weak self] _ in
                guard let current = self?.currentState else {
                    return
                }
                self?.action.onNext(.createNewClub(state: current))
            }),
            .init(title: "아니요", style: .default, handler: nil)
        ]))
        return .empty()
    }
    func createNewClub(state: State) -> Observable<Mutation> {
        let start = Observable.just(Mutation.setIsLoading(true))
        let task = Observable.zip(
            uploadImagesUseCase.execute(images: [state.bannerImg ?? Data()]).compactMap(\.first).asObservable(),
            uploadImagesUseCase.execute(images: state.activityImgs).asObservable()
        )
            .withUnretained(self)
            .flatMap { owner, urls -> Observable<Mutation> in
                let completable = owner.createNewClubUseCase.execute(
                    req: .init(
                        type: state.clubType,
                        name: state.name.clubTitleRegex(),
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
        return .concat([start, task])
    }
}
