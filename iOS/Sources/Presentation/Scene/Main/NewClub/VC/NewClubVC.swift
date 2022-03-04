import UIKit
import RxCocoa

final class NewClubVC: BaseVC<NewClubReactor> {
    // MARK: - Metric
    enum Metric {
        static let horizontalMargin: CGFloat = 15
    }
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let bannerLabel = HeaderLabel(title: "배너")
    private let bannerImageView = UIImageView().then {
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.image = GCMSAsset.Images.gcmsNewClubPlaceholder.image
    }
    private let clubNameLabel = HeaderLabel(title: "동아리 이름")
    private let clubNameTextField = NewClubTextField(placeholder: "동아리 이름을 입력해주세요.")
    private let clubDescriptionLabel = HeaderLabel(title: "동아리 소개")
    private let clubDescriptionTextView = UITextView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.layer.borderWidth = 1
        $0.clipsToBounds = true
        $0.backgroundColor = .clear
        $0.text = "동아리 소개를 입력해주세요."
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
        $0.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        $0.font = UIFont(font: GCMSFontFamily.Inter.medium, size: 13)
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
        $0.backgroundColor = .clear
    }
    private let teacherLabel = HeaderLabel(title: "담당 선생님")
    private let teacherTextField = NewClubTextField(placeholder: "선생님 이름을 입력해주세요.")
    private let memberLabel = HeaderLabel(title: "동아리 구성원")
    private let memberAppendButton = UIButton().then {
        $0.setImage(.init(systemName: "plus")?.tintColor(.white), for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = GCMSAsset.Colors.gcmsGray3.color.cgColor
        $0.clipsToBounds = true
    }
    private let memberCountLabel = UILabel()
    private let memberCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
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
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(contentView)
        contentView.addSubViews(
            bannerLabel, bannerImageView, clubNameLabel, clubNameTextField, clubDescriptionLabel, clubDescriptionTextView, clubActivitiesLabel, clubActivityAppendButton, clubActivitiesCollectionView, teacherLabel, teacherTextField, memberLabel, memberCountLabel, memberCollectionView, memberAppendButton, contactLabel, contactTextField, completeButton
        )
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        bannerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.leading.equalToSuperview().offset(Metric.horizontalMargin)
        }
        bannerImageView.snp.makeConstraints {
            $0.top.equalTo(bannerLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.width.equalTo(bound.width-30)
            $0.height.equalTo((bound.width-30)*0.6133)
        }
        clubNameLabel.snp.makeConstraints {
            $0.top.equalTo(bannerImageView.snp.bottom).offset(45)
            $0.leading.equalTo(bannerImageView)
        }
        clubNameTextField.snp.makeConstraints {
            $0.top.equalTo(clubNameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(52)
        }
        clubDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(clubNameTextField.snp.bottom).offset(45)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
        }
        clubDescriptionTextView.snp.makeConstraints {
            $0.top.equalTo(clubDescriptionLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(Metric.horizontalMargin)
            $0.height.equalTo(100)
        }
        clubActivitiesLabel.snp.makeConstraints {
            $0.top.equalTo(clubDescriptionTextView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        clubActivityAppendButton.snp.makeConstraints {
            $0.centerY.equalTo(clubActivitiesLabel)
            $0.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(44)
        }
        clubActivitiesCollectionView.snp.makeConstraints {
            $0.top.equalTo(clubActivitiesLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(80)
        }
        teacherLabel.snp.makeConstraints {
            $0.top.equalTo(clubActivitiesCollectionView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        teacherTextField.snp.makeConstraints {
            $0.top.equalTo(teacherLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(52)
        }
        memberLabel.snp.makeConstraints {
            $0.top.equalTo(teacherTextField.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        memberAppendButton.snp.makeConstraints {
            $0.centerY.equalTo(memberLabel)
            $0.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(44)
        }
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(memberLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(82)
        }
        memberCountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(memberCollectionView.snp.top)
        }
        contactLabel.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(15)
        }
        contactTextField.snp.makeConstraints {
            $0.top.equalTo(contactLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(52)
        }
        completeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contactTextField.snp.bottom).offset(50)
            $0.width.equalTo(166)
            $0.height.equalTo(33)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    // MARK: - Reactor
    override func bindView(reactor: NewClubReactor) {
        clubDescriptionTextView.rx.text.asObservable()
            .compactMap { $0 }
            .withUnretained(self)
            .bind { owner, _ in
                let size = CGSize(width: owner.view.frame.width, height: .infinity)
                let esti = owner.clubDescriptionTextView.sizeThatFits(size)
                
                owner.clubDescriptionTextView.constraints.forEach { constraint in
                    if esti.height < 100 {}
                    else {
                        if constraint.firstAttribute == .height {
                            constraint.constant = esti.height
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        clubDescriptionTextView.rx.didBeginEditing
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                if owner.clubDescriptionTextView.textColor == GCMSAsset.Colors.gcmsGray4.color {
                    owner.clubDescriptionTextView.text = nil
                    owner.clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray1.color
                }
            }
            .disposed(by: disposeBag)
        
        clubDescriptionTextView.rx.didEndEditing
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                if owner.clubDescriptionTextView.text.isEmpty {
                    owner.clubDescriptionTextView.text = "동아리 소개를 입력해주세요."
                    owner.clubDescriptionTextView.textColor = GCMSAsset.Colors.gcmsGray4.color
                }
            }
            .disposed(by: disposeBag)
    }
}
