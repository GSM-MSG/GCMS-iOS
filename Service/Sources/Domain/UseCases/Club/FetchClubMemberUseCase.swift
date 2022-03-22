import RxSwift

public final class FetchClubMemberUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery, isTest: Bool = false) -> Single<[User]> {
        clubRepository.fetchClubMember(query: query, isTest: isTest)
    }
}
