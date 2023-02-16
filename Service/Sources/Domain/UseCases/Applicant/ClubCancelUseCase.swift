import RxSwift

public struct ClubCancelUseCase {
    public init(clubApplicantRepository: ClubApplicantRepository) {
        self.clubApplicantRepository = clubApplicantRepository
    }
    
    private let clubApplicantRepository: ClubApplicantRepository
    
    public func execute(clubID: Int) -> Completable {
        clubApplicantRepository.cancel(clubID: clubID)
    }
}
