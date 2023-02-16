import RxSwift

public struct ClubApplyUseCase {
    public init(clubApplicantRepository: ClubApplicantRepository) {
        self.clubApplicantRepository = clubApplicantRepository
    }
    
    private let clubApplicantRepository: ClubApplicantRepository
    
    public func execute() -> Single<[User]> {
        clubApplicantRepository.apply()
    }
}
