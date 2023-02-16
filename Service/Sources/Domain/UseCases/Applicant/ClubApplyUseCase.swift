import RxSwift

public struct ClubApplyUseCase {
    public init(clubApplicantRepository: ClubApplicantRepository) {
        self.clubApplicantRepository = clubApplicantRepository
    }
    
    private let clubApplicantRepository: ClubApplicantRepository
    
    public func execute(clubID: Int) -> Completable {
        clubApplicantRepository.apply(clubID: clubID)
    }
}
