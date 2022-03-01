import UIKit
import GoogleSignIn
import Then

final class OnBoardingVC: BaseVC<OnBoardingReactor> {
    // MARK: - Properties
    private let headerLabel = UILabel().then {
        $0.text = "GSM동아리\n신청앱"
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    private let nameLabel = UILabel()
    private let logoImageView = UIImageView()
    private let googleSigninButton = GIDSignInButton()
    
    // MARK: - UI
    
}
