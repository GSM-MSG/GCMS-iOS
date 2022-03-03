import UIKit
import SnapKit

final class NoticeVC: BaseVC<NoticeReactor> {
    // MARK: - Properties
    private let contentTextView = UITextView()
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 18)
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(contentTextView, completeButton)
    }
    override func setLayout() {
        contentTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(15)
        }
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configTitle(title: "공지")
    }
}
