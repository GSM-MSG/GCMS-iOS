import UIKit

final class ClubManagementVC: BaseVC<ClubManagementReactor> {
    // MARK: - Properties
    private let noticeBarButton = UIBarButtonItem(image: .init(systemName: "megaphone.fill")?.tintColor(.white), style: .plain, target: nil, action: nil)
    private let bannerImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    private let contentView = UIView()
    private let waitListLabel = UILabel()
    private let waitListTableView = UITableView()
    private let deadlineButton = UIButton()
    
}
