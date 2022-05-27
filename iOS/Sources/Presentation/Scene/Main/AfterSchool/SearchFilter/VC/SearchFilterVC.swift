import UIKit
import SnapKit
import Then
import PanModal

final class SearchFilterVC: BaseVC<SearchFilterReactor> {
    // MARK: - Propreties
    private let headerLabel = UILabel().then {
        $0.text = "정렬"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    private let dayLabel = SegmentHeaderLabel(title: "요일")
    private let dayTypeSegment = FilterModalSegmentedControl(titles: ["월요일", "화요일", "수요일", "전체"])
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
        view.addSubViews(headerLabel, dayLabel, dayTypeSegment, gradeLabel, gradeTypeSegment, applyButton)
    }
    
    override func setLayout() {
        headerLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(8)
        }
        dayLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.top.equalTo(69)
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
}

// MARK: - PanModalPresentable
extension SearchFilterVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
}
