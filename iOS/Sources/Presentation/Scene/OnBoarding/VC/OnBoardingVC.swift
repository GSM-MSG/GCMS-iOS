import UIKit
import GoogleSignIn

final class OnBoardingVC: BaseVC<OnBoardingReactor> {
    // MARK: - Properties
    private let headerLabel = UILabel()
    private let nameLabel = UILabel()
    private let logoImageView = UIImageView()
    private let googleSigninButton = GIDSignInButton()
}
