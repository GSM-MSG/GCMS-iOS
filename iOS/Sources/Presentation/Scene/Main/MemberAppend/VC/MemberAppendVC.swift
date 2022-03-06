import UIKit
import PanModal
import RxSwift
import RxDataSources
import Service

final class MemberAppendVC: BaseVC<MemberAppendReactor> {
    // MARK: - Properties
    private let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 13)
    }
    private let completeButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 13)
    }
    private let currentUserListCollectionView = UICollectionView()
    private let searchTextField = UITextField().then {
        $0.textColor = .white
        $0.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 18)
    }
    private let studentListTableView = UITableView().then {
        $0.register(cellType: StudentCell.self)
        $0.rowHeight = 50
    }
    
    // MARK: - UI
    override func addView() {
        view.addSubViews(
            cancelButton, completeButton, currentUserListCollectionView, searchTextField, studentListTableView
        )
    }
    override func setLayout() {
        cancelButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(23)
        }
        completeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(23)
        }
        currentUserListCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(cancelButton.snp.bottom).offset(15)
            $0.height.equalTo(44)
        }
        searchTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(currentUserListCollectionView.snp.bottom).offset(15)
            $0.height.equalTo(50)
        }
        studentListTableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(searchTextField)
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Reactor
    override func bindState(reactor: MemberAppendReactor) {
        let sharedState = reactor.state.share(replay: 1).observe(on: MainScheduler.asyncInstance)
        
        let studentDS = RxTableViewSectionedReloadDataSource<StudentSection> { _, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: StudentCell.self)
            cell.model = item
            return cell
        }
        
        sharedState
            .map(\.users)
            .map { [StudentSection.init(items: $0)] }
            .bind(to: studentListTableView.rx.items(dataSource: studentDS))
            .disposed(by: disposeBag)
    }
    override func bindView(reactor: MemberAppendReactor) {
        completeButton.rx.tap
            .map { Reactor.Action.completeButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .map { Reactor.Action.cancelButtonDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        currentUserListCollectionView.rx.itemSelected
            .map(\.row)
            .map(Reactor.Action.removeAddedUser)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        studentListTableView.rx.modelSelected(User.self)
            .map(Reactor.Action.userDidTap)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchTextField.rx.text
            .map { $0 == nil ? "" : $0 }
            .compactMap { $0 }
            .map(Reactor.Action.updateQuery)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: - PanModal
extension MemberAppendVC: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return studentListTableView
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(bound.height*0.8)
    }
    var longFormHeight: PanModalHeight {
        return .contentHeight(bound.height*0.8)
    }
    var cornerRadius: CGFloat {
        return 10
    }
}
