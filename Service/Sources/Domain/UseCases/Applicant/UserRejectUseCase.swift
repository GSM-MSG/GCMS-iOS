import RxSwift
import Foundation

public struct UserRejectUseCase {
    public init(clubApplicantRepository: ClubApplicantRepository) {
        self.clubApplicantRepository = clubApplicantRepository
    }
    
    private let clubApplicantRepository: ClubApplicantRepository
    
    public func execute(clubID: String, uuid: UUID) -> Completable{
        clubApplicantRepository.userReject(clubID: clubID, uuid: uuid)
    }
}
