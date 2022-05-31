import UIKit
import SnapKit
import Then
import RxSwift
import Service
import PanModal

final class SearchFilterVC: BaseVC<SearchFilterReactor> {
    // MARK: - Propreties
    private let headerLabel = UILabel().then {
        $0.text = "정렬"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let semesterLabel = SegmentHeaderLabel(title: "학기")
    private let semesterTypeSegment = FilterModalSegmentedControl(titles: AfterSchoolSeason.allCases.map(\.display))
    private let dayLabel = SegmentHeaderLabel(title: "요일")
    private let dayTypeSegment = FilterModalSegmentedControl(titles: AfterSchoolWeek.allCases.map(\.segmentDisplay))
    private let gradeLabel = SegmentHeaderLabel(title: "학년")
    private let gradeTypeSegment = FilterModalSegmentedControl(titles: ["1학년", "2학년", "3학년", "전체"])
    private let applyButton = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.layer.cornerRadius = 8
        $0.contentHorizontalAlignment = .center
    }
    // MARK: - UI
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func addView() {
        view.addSubViews(headerLabel, semesterLabel, semesterTypeSegment, dayLabel, dayTypeSegment, gradeLabel, gradeTypeSegment, applyButton)
    }
    
    override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(8)
        }
        semesterLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.equalTo(69)
        }
        semesterTypeSegment.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(semesterLabel.snp.bottom).offset(8)
            $0.height.equalTo(32)
        }
        dayLabel.snp.makeConstraints {
            $0.leading.equalTo(semesterLabel.snp.leading)
            $0.top.equalTo(semesterTypeSegment.snp.bottom).offset(40)
        }
        dayTypeSegment.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(dayLabel.snp.bottom).offset(8)
            $0.height.equalTo(32)
        }
        gradeLabel.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.leading)
            $0.top.equalTo(dayTypeSegment.snp.bottom).offset(40)
        }
        gradeTypeSegment.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(gradeLabel.snp.bottom).offset(8)
            $0.height.equalTo(32)
        }
        applyButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.top.equalTo(gradeTypeSegment.snp.bottom).offset(56)
        }
    }
    // MARK: - Reactor
    
    override func bindView(reactor: SearchFilterReactor) {
        applyButton.rx.tap
            .map { Reactor.Action.applyButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - PanModalPresentable
extension SearchFilterVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(500)
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(500)
    }
    
    func segmentValueChanged(to index: Int, sender: FilterModalSegmentedControl) {
        if sender == semesterTypeSegment {
            var season: AfterSchoolSeason = .first
            switch index {
            case 0:
                season = .first
            case 1:
                season = .second
            case 2:
                season = .summer
            case 3:
                season = .winter
            default:
                return
            }
            reactor?.action.onNext(.segementedSeasonCange(season))
        } else if sender == dayTypeSegment {
            var week: AfterSchoolWeek = .all
            switch index {
            case 0:
                week = .monday
            case 1:
                week = .tuesday
            case 2:
                week = .wednesday
            case 3:
                week = .all
            default:
                return
            }
            reactor?.action.onNext(.segementedWeekChange(week))
        } else if sender == gradeTypeSegment {
            let grade = index == 3 ? 0 : index
            reactor?.action.onNext(.segementedGradeChange(grade))
        }
    }
}
