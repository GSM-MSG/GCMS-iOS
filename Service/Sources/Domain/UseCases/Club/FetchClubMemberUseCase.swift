import RxSwift

public struct FetchClubMemberUseCase {
    public init(clubMemberRepository: ClubMemberRepository) {
        self.clubMemberRepository = clubMemberRepository
    }
    
    private let clubMemberRepository: ClubMemberRepository
    
    public func execute(clubID: String) -> Single<[Member]> {
        clubMemberRepository.fetchClubMember(clubID: clubID)
    }
}
