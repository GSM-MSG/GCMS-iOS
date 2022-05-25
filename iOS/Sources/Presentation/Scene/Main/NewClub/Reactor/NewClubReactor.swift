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
        
        //Second
        case updateTitle(String)
        case updateDescription(String)
        case updateLinkName(String)
        case updateLinkUrl(String)
        case updateTeacher(String?)
        case updateContact(String)
        case secondNextButtonDidTap
        
        // Third
        case imageDidSelect(Data)
        case bannerDidTap
        case activityAppendButtonDidTap
        case activityDeleteDidTap(Int)
        case memberAppendButtonDidTap
        case memberDidSelected([User])
        case memberRemove(Int)
        case updateLoading(Bool)
        case completeButtonDidTap
        
        // etc
        case createNewClub(state: State)
    }
    enum Mutation {
        case setTitle(String)
        case setDescription(String)
        case setLinkName(String)
        case setLinkUrl(String)
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
        var title: String
        var description: String
        var linkName: String
        var linkUrl: String
        var contact: String
        var teacher: String?
        var isBanner: Bool
        var imageData: Data?
        var activitiesData: [Data]
        var members: [User]
        var clubType: ClubType
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
            title: "",
            description: "",
            linkName: "노션 링크",
            linkUrl: "",
            contact: "",
            isBanner: false,
            activitiesData: [],
            members: [],
            clubType: .major,
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
        case let .updateTitle(title):
            return .just(.setTitle(title))
        case .completeButtonDidTap:
            return completeButtonDidTap()
        case let .updateDescription(desc):
            return .just(.setDescription(desc))
        case let .updateLinkName(name):
            return .just(.setLinkName(name))
        case let .updateLinkUrl(url):
            return .just(.setLinkUrl(url))
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
        case .activityAppendButtonDidTap:
            return .just(.setIsBanner(false))
        case let .activityDeleteDidTap(index):
            return .just(.removeImageData(index))
        case .memberAppendButtonDidTap:
            steps.accept(GCMSStep.memberAppendIsRequired(closue: { [weak self] users in
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
        case let .setTitle(title):
            newState.title = title
        case let .setDescription(desc):
            newState.description = desc
        case let .setLinkName(name):
            newState.linkName = name
        case let .setLinkUrl(url):
            newState.linkUrl = url
        case let .setContact(cont):
            newState.contact = cont
        case let .setTeacher(teac):
            newState.teacher = teac
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
        if currentState.title.isEmpty {
            errorMessage = "동아리 이름을 입력해주세요!"
        }
        else if currentState.description.isEmpty || currentState.description == "동아리 설명을 입력해주세요." {
            errorMessage = "동아리 설명을 입력해주세요!"
        }
        else if currentState.contact.isEmpty {
            errorMessage = "연락처를 입력해주세요!"
        } else if currentState.linkName.isEmpty || currentState.linkUrl.isEmpty {
            errorMessage = "링크이름 및 URL를 입력해주세요!"
        } else {
            steps.accept(GCMSStep.thirdNewClubIsRequired(reactor: self))
        }
        if !errorMessage.isEmpty {
            steps.accept(GCMSStep.failureAlert(title: errorMessage, message: nil, action: nil))
        }
        return .empty()
    }
    func completeButtonDidTap() -> Observable<Mutation> {
        guard (currentState.imageData != nil)  else {
            steps.accept(GCMSStep.failureAlert(title: "동아리 배너 이미지를 넣어주세요!", message: nil, action: nil))
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
            uploadImagesUseCase.execute(images: [state.imageData ?? Data()]).compactMap(\.first).asObservable(),
            uploadImagesUseCase.execute(images: state.activitiesData).asObservable()
        ).withUnretained(self).flatMap { owner, urls -> Observable<Mutation> in
            let relatedLink: RelatedLinkDTO = .init(name: state.linkName, url: state.linkUrl)
            return owner.createNewClubUseCase.execute(
                req: .init(
                    type: state.clubType,
                    title: state.title,
                    description: state.description,
                    bannerUrl: urls.0,
                    contact: state.contact,
                    relatedLink: relatedLink,
                    teacher: state.teacher,
                    activities: urls.1,
                    member: state.members.map(\.userId)
                )
            )
            .do(afterCompleted: {
                owner.steps.accept(GCMSStep.popToRoot)
            })
            .andThen(Observable.just(Mutation.setIsLoading(false)))
            .catchAndReturn(.setIsLoading(false))
        }
            .catchAndReturn(.setIsLoading(false))
        return .concat([start, task])
    }
}
