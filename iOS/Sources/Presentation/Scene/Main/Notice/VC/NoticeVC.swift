import UIKit
import SnapKit
import RxDataSources
import RxSwift

final class NoticeVC: BaseVC<NoticeReactor> {
    // MARK: - Properties
    private let contentTextView = UITextView().then {
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        $0.text = "공지할 내용을 입력해주세요."
        $0.textColor = GCMSAsset.Colors.gcmsGray4.color
        $0.font = UIFont(font: GCMSFontFamily.Inter.bold, size: 13)
    }
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 18)
        $0.layer.cornerRadius = 5
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(contentTextView, completeButton)
    }
    override func setLayout() {
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.bottom.equalToSuperview().offset(-30)
            $0.height.equalTo(50)
        }
        contentTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.bottom.equalTo(completeButton.snp.top).offset(-30)
        }
    }
    
    override func configureVC() {
        self.view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    
    override func configureNavigation() {
        self.navigationItem.configTitle(title: "공지")
    }
    
    // MARK: - Reactor
    
    override func bindView(reactor: NoticeReactor) {
        contentTextView.rx.didBeginEditing
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                if owner.contentTextView.textColor == GCMSAsset.Colors.gcmsGray4.color {
                    owner.contentTextView.text = nil
                    owner.contentTextView.textColor = GCMSAsset.Colors.gcmsGray1.color
                }
            }
            .disposed(by: disposeBag)
        
        contentTextView.rx.didEndEditing
            .asObservable()
            .withUnretained(self)
            .bind { owner, _ in
                if owner.contentTextView.text.isEmpty {
                    owner.contentTextView.text = "공지할 내용을 입력해주세요."
                    owner.contentTextView.textColor = GCMSAsset.Colors.gcmsGray4.color
                }
            }
            .disposed(by: disposeBag)
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
