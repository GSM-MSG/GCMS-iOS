import RxSwift

public final class FetchDetailClubUseCase {
    public init(clubRepository: ClubRepository) {
        self.repository = clubRepository
    }
    
    private let repository: ClubRepository
    
    func execute(name: String, type: ClubType, isTest: Bool = false) -> Single<DetailClub> {
        repository.fetchDetailClub(name: name, type: type, isTest: isTest)
    }
}
