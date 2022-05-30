import UIKit
import SnapKit
import Then
import Service

final class AfterSchoolTableViewCell: BaseTableViewCell<AfterSchool> {
    // MARK: - Propreties
    private let afterSchoolNameLabel = SemiBoldTextLabel(weight: .semibold).then {
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        $0.layer.cornerRadius = 5
    }
    private let periodLabel = SemiBoldTextLabel(weight: .regular)
    private let gradeLabel = SemiBoldTextLabel(weight: .semibold)
    private let participantsLabel = SemiBoldTextLabel(weight: .semibold)
    private let applyButton = UIButton().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.layer.cornerRadius = 5
        $0.setTitle("신청", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        $0.contentHorizontalAlignment = .center
    }
    // MARK: - UI
    override func addView() {
        contentView.addSubViews(afterSchoolNameLabel, periodLabel, gradeLabel, participantsLabel, applyButton)
    }

    override func setLayout() {
        afterSchoolNameLabel.snp.makeConstraints {
            $0.leading.equalTo(15)
            $0.height.equalTo(40)
            $0.width.equalTo(bound.width*0.22)
        }
        periodLabel.snp.makeConstraints {
            $0.leading.equalTo(afterSchoolNameLabel.snp.trailing)
            $0.height.equalTo(40)
            $0.width.equalTo(bound.width*0.232)
        }
        gradeLabel.snp.makeConstraints {
            $0.leading.equalTo(periodLabel.snp.trailing)
            $0.height.equalTo(40)
            $0.width.equalTo(bound.width*0.14)
        }
        participantsLabel.snp.makeConstraints {
            $0.leading.equalTo(gradeLabel.snp.trailing)
            $0.height.equalTo(40)
            $0.width.equalTo(bound.width*0.168)
        }
        applyButton.snp.makeConstraints {
            $0.leading.equalTo(participantsLabel.snp.trailing).offset(-4)
            $0.height.equalTo(40)
            $0.width.equalTo(bound.width*0.175)
        }
    }
    
    override func bind(_ model: AfterSchool) {
        afterSchoolNameLabel.text = model.title
        periodLabel.text = model.week.display
        gradeLabel.text = "\(model.grade)학년"
        participantsLabel.text = "\(model.personnel)/\(model.maxPersonnel)"
        applyButton.setTitle(model.isApplied ? "신청" : "취소", for: .normal)
    }
}
