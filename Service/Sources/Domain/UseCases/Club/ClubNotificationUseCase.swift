import RxSwift

public final class ClubNotificationUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(
        name: String,
        type: ClubType,
        req: NotificationRequest,
        isTest: Bool = false
    ) -> Completable {
        clubRepository.clubNotification(name: name, type: type, req: req, isTest: isTest)
    }
}
