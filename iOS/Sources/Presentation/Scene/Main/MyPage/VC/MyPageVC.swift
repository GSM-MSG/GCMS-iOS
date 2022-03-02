import UIKit

final class MyPageVC: BaseVC<MyPageReactor> {
    // MARK: - Properties
    private let userProfileImageView = UIImageView().then {
        $0.layer.cornerRadius = 85/2
        $0.clipsToBounds = true
    }
    private let usernameLabel = UILabel()
    private let classLabel = UILabel()
    private let managementButton = UIButton()
}
