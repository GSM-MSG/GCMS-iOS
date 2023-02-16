import RxSwift
import Foundation

public struct UserAcceptUseCase {
    public init(clubApplicantRepository: ClubApplicantRepository) {
        self.clubApplicantRepository = clubApplicantRepository
    }
    
    private let clubApplicantRepository: ClubApplicantRepository
    
    public func execute(clubID: Int, uuid: UUID) -> Completable{
        clubApplicantRepository.userAccept(clubID: clubID, uuid: uuid)
    }
}
