import UIKit

final class NewClubVC: BaseVC<NewClubReactor> {
    // MARK: - Properties
    private let bannerLabel = HeaderLabel(title: "배너")
    private let bannerImageView = UIImageView()
    private let clubNameLabel = HeaderLabel(title: "동아리 이름")
    private let clubNameTextField = UITextField()
    private let clubDescriptionLabel = HeaderLabel(title: "동아리 소개")
    private let clubDescriptionTextView = UITextView()
    private let clubActivitiesLabel = HeaderLabel(title: "동아리 활동")
    private let clubActivityAppendButton = UIButton()
    private let clubActivitiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
    }
    private let teacherLabel = HeaderLabel(title: "담당 선생님")
    private let teacherTextField = UITextField()
    private let memberLabel = HeaderLabel(title: "동아리 구성원")
    private let memberAppendButton = UIButton()
    private let memberCountLabel = UILabel()
    private let memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
    }
    private let contactLabel = HeaderLabel(title: "연락처")
    private let contactTextField = UITextField()
}
