import UIKit
import SnapKit

final class UpdateSteppedProgressBar: UIView {
    // MARK: - Properties
    private let firstStepView = NewClubStepView(level: 1, title: "동아리 소개")
    private let secondStepView = NewClubStepView(level: 2, title: "세부사항")
    private let lineView = UIView().then {
        $0.backgroundColor = UIColor(red: 0.454, green: 0.454, blue: 0.454, alpha: 1)
    }
    
    // MARK: - UI
    init(selectedIndex: Int) {
        super.init(frame: .zero)
        [firstStepView, secondStepView][selectedIndex].isSelected = true
        addView()
        setLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension UpdateSteppedProgressBar {
    func addView() {
        addSubViews(lineView, firstStepView, secondStepView)
    }
    func setLayout() {
        firstStepView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(30)
        }
        secondStepView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.size.equalTo(30)
        }
        lineView.snp.makeConstraints {
            $0.centerY.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    func configureView() {
        
    }
}
