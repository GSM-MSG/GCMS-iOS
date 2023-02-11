
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
        case updatename(String)
        case updatecontent(String)
        case updateTeacher(String)
        case updateNotionLink(String)
        case updateContact(String)
        case secondNextButtonDidTap
        
        // Third
        case imageDidSelect(Data)
        case bannerDidTap
        case activityAppendButtonDidTap
        case activityDeleteDidTap(Int)
        case updateLoading(Bool)
        case completeButtonDidTap
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
        case setClubType(ClubType)
        case setIsLoading(Bool)
    }
    struct State {
        var name: String
        var content: String
        var notionLink: String
        var contact: String
        var teacher: String?
        var isBanner: Bool
        var bannerImg: Data?
        var activityImgs: [Data]
        var clubType: ClubType
        var isLoading: Bool
    }
    let initialState: State
    private let legacyBanner: Data?
    private let legacyBannerUrl: String
    private let legacyImageUrl: [Data: String]
    private let updateClubUseCase: UpdateClubUseCase
    private let uploadImagesUseCase: UploadImagesUseCase
    
    // MARK: - Init
    init(
        club: Club,
        updateClubUseCase: UpdateClubUseCase,
        uploadImagesUseCase: UploadImagesUseCase
    ) {
        self.legacyBannerUrl = club.bannerImg
        self.legacyBanner = try? Data(contentsOf: URL(string: club.bannerUrl)!)
        var activityImgs = [Data]()
        self.legacyImageUrl = club.activities.reduce(into: [Data:String](), { partialResult, url in
            if let data = try? Data(contentsOf: URL(string: url)!) {
                partialResult[data] = url
                activityImgs.append(data)
            }
        })
        initialState = State(
            name: club.name,
            content: club.content,
            notionLink: club.notionLink,
            contact: club.contact,
            teacher: club.teacher,
            isBanner: true,
            bannerImg: try? Data(contentsOf: URL(string: club.bannerImg)!),
            activityImgs: activityImgs,
            clubType: club.type,
            isLoading: false
        )
        self.updateClubUseCase = updateClubUseCase
        self.uploadImagesUseCase = uploadImagesUseCase
        
    }
    
}

// MARK: - Mutate
extension UpdateClubReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updatename(name):
            return .just(.setName(name))
        case .completeButtonDidTap:
            return completeButtonDidTap()
        case let .updatecontent(content):
            return .just(.setContent(desc))
        case let .updateNotionLink(link):
            return .just(.setNotionLink(link))
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
        if currentState.name.isEmpty {
            errorMessage = "동아리 이름을 입력해주세요!"
        }
        else if currentState.content.isEmpty || currentState.content == "동아리 설명을 입력해주세요." {
            errorMessage = "동아리 설명을 입력해주세요!"
        }
        else if currentState.contact.isEmpty {
            errorMessage = "연락처를 입력해주세요!"
        }
        else if currentState.notionLink.isEmpty || !currentState.notionLink.hasPrefix("https://") {
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
    func updateClub(banner: String? = nil, added: [String]) {
        let banner = banner == nil ? self.legacyBannerUrl : banner ?? .init()
        let initial = self.initialState
        let current = self.currentState
        self.updateClubUseCase.execute(
            req: .init(
                type: initial.clubType,
                name: current.name.clubTitleRegex(),
                content: current.content,
                bannerImg: banner,
                contact: current.contact,
                notionLink: current.notionLink,
                teacher: current.teacher,
                activityImgs: current.activityImgs,
                member: current.member,
            )
        )
        .andThen(Observable.just(()))
            .catch { e in
                self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                return .just(())
            }
            .asObservable()
            .bind { _ in
                self.steps.accept(GCMSStep.popToRoot)
            }
            .disposed(by: self.disposeBag)
    }
    func completeButtonDidTap() -> Observable<Mutation> {
        guard (currentState.bannerImg != nil)  else {
            steps.accept(GCMSStep.failureAlert(title: "동아리 배너 이미지를 넣어주세요!", message: nil))
            return .empty()
        }
        let current = self.currentState
        steps.accept(GCMSStep.alert(title: "정말로 완료하시겠습니까?", message: nil, style: .alert, actions: [
            .init(title: "예", style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                if current.imageData != self.legacyBanner {
                    Observable.zip(
                        self.uploadImagesUseCase.execute(images: [current.imageData ?? .init()]).compactMap(\.first).asObservable(),
                        self.uploadImagesUseCase.execute(images: current.addedImage).asObservable()
                    )
                    .subscribe(onNext: { (banner, added) in
                        self.updateClub(banner: banner, added: added)
                    }, onError: { e in
                        self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                    })
                    .disposed(by: self.disposeBag)
                } else {
                    self.uploadImagesUseCase.execute(images: current.addedImage).asObservable()
                        .subscribe { added in
                            self.updateClub(added: added)
                        } onError: { e in
                            self.steps.accept(GCMSStep.failureAlert(title: "실패", message: e.asGCMSError?.errorDescription))
                        }
                        .disposed(by: self.disposeBag)
                }
            }),
            .init(title: "아니요", style: .default, handler: nil)
        ]))
        return .empty()
    }
}
