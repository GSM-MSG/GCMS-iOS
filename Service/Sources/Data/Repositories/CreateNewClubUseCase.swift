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
        teachre: String,
        head: String,
        discord: String,
        clubPicture: [Data],
        clubMember: [Int],
        isTest: Bool = false
    ) -> Completable {
        return Single.zip(imageRepository.uploadPicture(data: picture, isTest: isTest),
                   imageRepository.uploadPictures(datas: clubPicture, isTest: isTest))
            .flatMapCompletable { bannerUrl, pictureUrls in
                self.clubRepository.createNewClub(
                    req: .init(
                        picture: bannerUrl,
                        type: type,
                        name: name,
                        description: description,
                        teacher: teachre,
                        head: head,
                        discord: discord,
                        clubPicture: pictureUrls,
                        clubMember: clubMember
                    ), isTest: isTest
                )
            }
    }
}
