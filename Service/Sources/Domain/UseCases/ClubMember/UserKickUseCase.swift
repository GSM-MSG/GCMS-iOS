import RxSwift
import Foundation

public final class UserKickUseCase {
    public init(clubMemberRepository: ClubMemberRepository) {
        self.clubMemberRepository = clubMemberRepository
    }

    private let clubMemberRepository: ClubMemberRepository

    public func execute(
        clubID: Int,
        uuid: UUID
    ) -> Completable {
        clubMemberRepository.userKick(clubID: clubID, uuid: uuid)
    }
}
