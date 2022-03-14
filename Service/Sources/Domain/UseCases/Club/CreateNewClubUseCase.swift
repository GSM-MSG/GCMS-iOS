import RxSwift
import Foundation

public final class CreateNewClubUseCase {
    public init(clubRepository: ClubRepository, imageRepository: ImageRepository) {
        self.clubRepository = clubRepository
        self.imageRepository = imageRepository
    }
    
    private let clubRepository: ClubRepository
    private let imageRepository: ImageRepository
    
    public func execute(
        picture: Data,
        type: ClubType,
        name: String,
        description: String,
        teacher: String,
        head: String,
        discord: String,
        clubPicture: [Data],
        clubMember: [Int],
        isTest: Bool = false
    ) -> Completable {
        return Single.zip(imageRepository.uploadPictures(datas: [picture], isTest: isTest),
                   imageRepository.uploadPictures(datas: clubPicture, isTest: isTest))
            .flatMapCompletable { bannerUrl, pictureUrls in
                self.clubRepository.createNewClub(
                    req: .init(
                        picture: bannerUrl.first ?? "",
                        type: type,
                        name: name,
                        description: description,
                        teacher: teacher,
                        head: head,
                        discord: discord,
                        clubPicture: pictureUrls,
                        clubMember: clubMember
                    ), isTest: isTest
                )
            }
    }
}
