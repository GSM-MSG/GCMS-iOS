import RxSwift

public struct ClubOpenUseCase {
    public init(clubRepository: ClubRepository) {
        self.clubRepository = clubRepository
    }

    private let clubRepository: ClubRepository

    public func execute(clubID: Int) -> Completable {
        clubRepository.clubOpen(clubID: clubID)
    }
}
