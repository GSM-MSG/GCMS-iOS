import RxSwift

public struct ClubCancelUseCase {
    public init(clubApplicantRepository: ClubApplicantRepository) {
        self.clubApplicantRepository = clubApplicantRepository
    }
    
    private let clubApplicantRepository: ClubApplicantRepository
    
    public func execute() -> Completable {
        clubApplicantRepository.cancel()
    }
}
