import RxSwift

public struct FetchClubMemberUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }
    
    private let clubRepository: ClubRepository
    
    public func execute(query: ClubRequestQuery) -> Single<[Member]> {
        clubRepository.fetchClubMember(query: query)
    }
}
