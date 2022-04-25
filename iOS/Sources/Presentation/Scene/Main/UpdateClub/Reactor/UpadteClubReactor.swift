
import ReactorKit
import RxFlow
import RxSwift
import RxRelay
import UIKit
import Service

final class UpdateClubReactor: Reactor, Stepper {
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
        case updateLinkName(String?)
        case updateLinkUrl(String?)
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
    }
    enum Mutation {
        case setTitle(String)
        case setDescription(String)
        case setLinkName(String?)
        case setLinkUrl(String?)
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
        var linkName: String?
        var linkUrl: String?
        var contact: String
        var teacher: String?
        var isBanner: Bool
        var imageData: Data?
        var activitiesData: [Data]
        var members: [User]
        var clubType: ClubType
        var addedUser: [User]
        var removedUser: [User]
        var addedImage: [Data]
        var removedImage: [String]
        var isLoading: Bool
    }
    let initialState: State
    private let legacyMember: [User]
    private let legacyImageUrl: [Data: String]
    
    // MARK: - Init
    init(club: Club) {
        self.legacyMember = club.member
        self.legacyImageUrl = club.activities.reduce(into: [Data:String](), { partialResult, url in
            if let data = try? Data(contentsOf: URL(string: url)!) {
                partialResult[data] = url
            }
        })
        initialState = State(
            title: club.title,
            description: club.description,
            linkName: club.relatedLink.first?.name,
            linkUrl: club.relatedLink.first?.url,
            contact: club.contact,
            teacher: club.teacher,
            isBanner: true,
            imageData: try? Data(contentsOf: URL(string: club.bannerUrl)!),
            activitiesData: club.activities.compactMap { try? Data(contentsOf: URL(string: $0)!) },
            members: club.member,
            clubType: club.type,
            addedUser: [],
            removedUser: [],
            addedImage: [],
            removedImage: [],
            isLoading: false
        )
    }
    
}

// MARK: - Mutate
extension UpdateClubReactor {
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
            steps.accept(GCMSStep.secondUpdateClubIsRequired(reactor: self))
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
                    newState.addedImage.append(data)
                }
            }
        case let .setIsBanner(status):
            newState.isBanner = status
        case let .removeImageData(index):
            let removed = newState.activitiesData.remove(at: index)
            newState.addedImage.removeAll(where: { $0 == removed } )
            if let legacy = legacyImageUrl[removed] {
                newState.removedImage.append(legacy)
            }
        case let .appendMember(users):
            newState.members.append(contentsOf: users)
            newState.members.removeDuplicates()
            newState.addedUser.append(contentsOf: users)
            newState.addedUser.removeDuplicates()
        case let .memberRemove(index):
            let removed = newState.members.remove(at: index)
            newState.addedUser.removeAll(where: { $0 == removed } )
            if legacyMember.contains(removed) {
                newState.removedUser.append(removed)
            }
        case let .setClubType(type):
            newState.clubType = type
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
        if currentState.title.isEmpty && initialState.title.isEmpty {
            errorMessage = "동아리 이름을 입력해주세요!"
        }
        else if currentState.description.isEmpty || currentState.description == "동아리 설명을 입력해주세요." {
            errorMessage = "동아리 설명을 입력해주세요!"
        }
        else if currentState.contact.isEmpty && initialState.contact.isEmpty {
            errorMessage = "연락처를 입력해주세요!"
        } else {
            steps.accept(GCMSStep.thirdUpdateClubIsRequired(reactor: self))
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
                self?.steps.accept(GCMSStep.popToRoot)
            }),
            .init(title: "아니요", style: .default, handler: nil)
        ]))
        return .empty()
    }
}
