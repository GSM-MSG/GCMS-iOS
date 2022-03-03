import UIKit

final class NewClubVC: BaseVC<NewClubReactor> {
    // MARK: - Properties
    private let bannerLabel = HeaderLabel(title: "배너")
    private let bannerImageView = UIImageView().then {
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    private let clubNameLabel = HeaderLabel(title: "동아리 이름")
    private let clubNameTextField = UITextField().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
    }
    private let clubDescriptionLabel = HeaderLabel(title: "동아리 소개")
    private let clubDescriptionTextView = UITextView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
    }
    private let clubActivitiesLabel = HeaderLabel(title: "동아리 활동")
    private let clubActivityAppendButton = UIButton().then {
        $0.setImage(.init(systemName: "plus")?.tintColor(.white), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.clipsToBounds = true
    }
    private let clubActivitiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
    }
    private let teacherLabel = HeaderLabel(title: "담당 선생님")
    private let teacherTextField = UITextField().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
    }
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
