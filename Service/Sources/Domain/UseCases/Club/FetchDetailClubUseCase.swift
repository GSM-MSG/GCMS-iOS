import RxSwift

public final class FetchDetailClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.repository = clubRepository
    }
    
    private let repository: ClubRepository
    
    func execute(id: Int, isTest: Bool = false) -> Single<DetailClub> {
        repository.fetchDetailClub(id: id, isTest: isTest)
    }
}
