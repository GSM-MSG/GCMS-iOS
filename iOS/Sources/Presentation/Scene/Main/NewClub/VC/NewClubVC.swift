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
    private let clubNameTextField = NewClubTextField(placeholder: "동아리 이름을 입력해주세요.")
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
    private let teacherTextField = NewClubTextField(placeholder: "선생님 이름을 입력해주세요.")
    private let memberLabel = HeaderLabel(title: "동아리 구성원")
    private let memberAppendButton = UIButton()
    private let memberCountLabel = UILabel()
    private let memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
    }
    private let contactLabel = HeaderLabel(title: "연락처")
    private let contactTextField = NewClubTextField(placeholder: "연락처를 입력해주세요.;(디스코드, 전화번호 등)")
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
    }
}
