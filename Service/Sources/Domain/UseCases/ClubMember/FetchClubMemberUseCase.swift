import RxSwift

public struct FetchClubMemberUseCase {
    public init(clubMemberRepository: ClubMemberRepository) {
        self.clubMemberRepository = clubMemberRepository
    }

    private let clubMemberRepository: ClubMemberRepository

    public func execute(clubID: Int) -> Single<(MemberScope, [Member])> {
        clubMemberRepository.fetchClubMember(clubID: clubID)
    }
}
