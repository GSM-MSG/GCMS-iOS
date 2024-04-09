import UIKit
import SnapKit
import Configure

final class ClubAttendVC: BaseVC<ClubAttendReactor> {
    private let membersTableView = UITableView().then {
        $0.register(cellType: ClubMemberListCell.self)
        $0.estimatedRowHeight = 40
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
        $0.separatorStyle = .none
        $0.sectionHeaderHeight = 0
    }
    private let attendButton = UIButton().then {
        $0.setTitle("출석체크하기", for: .normal)
        $0.setTitleColor(GCMSAsset.Colors.gcmsGray1.color, for: .normal)
        $0.titleLabel?.font = UIFont(font: GCMSFontFamily.Inter.semiBold, size: 13)
        $0.backgroundColor = GCMSAsset.Colors.gcmsMainColor.color
        $0.layer.cornerRadius = 9
        $0.clipsToBounds = true
    }
    private let settingButton = UIBarButtonItem(image: .init(systemName: "gearshape.fill")?.tintColor(.white), style: .plain, target: nil, action: nil)

    override init(reactor: ClubAttendReactor?) {
        super.init(reactor: reactor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        membersTableView.delegate = self
        membersTableView.dataSource = self
    }
    override func addView() {
        view.addSubViews(attendButton, membersTableView)
    }
    override func setLayout() {
        attendButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(52)
        }
        membersTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(attendButton.snp.top)
        }
    }
    override func configureVC() {
        view.backgroundColor = GCMSAsset.Colors.gcmsBackgroundColor.color
    }
    override func configureNavigation() {
        self.navigationItem.configBack()
        self.navigationItem.setRightBarButton(settingButton, animated: true)
        self.navigationItem.title = "동아리 출석"
    }
}

extension ClubAttendVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ClubMemberListCell.self)
    return cell
    }
}
