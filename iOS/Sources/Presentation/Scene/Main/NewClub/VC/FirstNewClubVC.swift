import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Service

final class FirstNewClubVC: BaseVC<NewClubReactor> {
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let progressBar = NewClubSteppedProgressBar(selectedIndex: 0)
    private let majorButton = ClubTypeCardButton(type: .major)
    private let freedomButton = ClubTypeCardButton(type: .freedom)
    private let editorialButton = ClubTypeCardButton(type: .editorial)

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
    override func bindView(reactor: NewClubReactor) {
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
}
