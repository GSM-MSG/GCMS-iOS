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
        imageRepository.uploadPicture(data: picture, isTest: isTest)
            .flatMapCompletable { bannerUrl in
                self.imageRepository.uploadPictures(datas: clubPicture, isTest: isTest)
                    .flatMapCompletable { pictures in
                        return self.clubRepository.createNewClub(
                            req: .init(
                                picture: bannerUrl,
                                type: type,
                                name: name,
                                description: description,
                                teacher: teachre,
                                head: head,
                                discord: discord,
                                clubPicture: pictures,
                                clubMember: clubMember)
                            , isTest: isTest
                        )
                    }
            }
        
    }
}
