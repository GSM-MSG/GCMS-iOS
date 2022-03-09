import UIKit
import SnapKit
import RxSwift

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
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }
        contentTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.bottom.equalTo(completeButton.snp.top).offset(-30)
        }
    }
    override func configureNavigation() {
        self.navigationItem.configTitle(title: "공지")
    }
    
    // MARK: - Reator
    override func bindState(reactor: NoticeReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.isLoading)
            .bind(with: self) { owner, load in
                load ? owner.startIndicator() : owner.stopIndicator()
            }
            .disposed(by: disposeBag)
    }
}
