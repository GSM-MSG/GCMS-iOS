import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Service

final class FirstUpdateClubVC: BaseVC<UpdateClubReactor> {
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let progressBar = NewClubSteppedProgressBar(selectedIndex: 0)
    private let majorButton = ClubTypeCardButton(type: .major, isGray: true)
    private let freedomButton = ClubTypeCardButton(type: .freedom, isGray: true)
    private let editorialButton = ClubTypeCardButton(type: .editorial, isGray: true)
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(scrollView)
        scrollView.addSubViews(progressBar, majorButton, freedomButton, editorialButton)
    }
    override func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        progressBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(30)
        }
        majorButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(progressBar.snp.bottom).offset(75)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo((bound.width-40)*0.43125)
        }
        freedomButton.snp.makeConstraints {
            $0.leading.trailing.height.centerX.equalTo(majorButton)
            $0.top.equalTo(majorButton.snp.bottom).offset(15)
        }
        editorialButton.snp.makeConstraints {
            $0.leading.trailing.height.centerX.equalTo(freedomButton)
            $0.top.equalTo(freedomButton.snp.bottom).offset(15)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationItem.configBack()
    }
    
    // MARK: - Reactor
    override func bindView(reactor: UpdateClubReactor) {
        majorButton.rx.tap
            .map { Reactor.Action.clubTypeDidTap(.major) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        freedomButton.rx.tap
            .map { Reactor.Action.clubTypeDidTap(.freedom) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        editorialButton.rx.tap
            .map { Reactor.Action.clubTypeDidTap(.editorial) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    override func bindState(reactor: UpdateClubReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        sharedState
            .map(\.clubType)
            .bind(with: self) { owner, type in
                switch type {
                case .major:
                    owner.majorButton.setImageState(isGray: false)
                    owner.freedomButton.setImageState(isGray: true)
                    owner.editorialButton.setImageState(isGray: true)
                case .freedom:
                    owner.majorButton.setImageState(isGray: true)
                    owner.freedomButton.setImageState(isGray: false)
                    owner.editorialButton.setImageState(isGray: true)
                case .editorial:
                    owner.majorButton.setImageState(isGray: true)
                    owner.freedomButton.setImageState(isGray: true)
                    owner.editorialButton.setImageState(isGray: false)
                }
            }
            .disposed(by: disposeBag)
    }
}
