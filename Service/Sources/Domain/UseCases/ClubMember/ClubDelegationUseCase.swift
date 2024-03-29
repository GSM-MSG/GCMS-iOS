import RxSwift
import Foundation

public struct ClubDelegationUseCase {
    public init(clubMemberRepository: ClubMemberRepository) {
        self.clubMemberRepository = clubMemberRepository
    }

    private let clubMemberRepository: ClubMemberRepository

    public func execute(clubID: Int, uuid: UUID) -> Completable {
        clubMemberRepository.delegation(clubID: clubID, uuid: uuid)
    }
}
