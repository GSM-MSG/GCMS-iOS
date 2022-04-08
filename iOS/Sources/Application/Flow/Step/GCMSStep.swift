import RxFlow
import UIKit
import Service
import Loaf

enum GCMSStep: Step {
    // MARK: Global
    case loaf(_ message: String, state: Loaf.State, location: Loaf.Location)
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case failureAlert(title: String?, message: String?, action: UIAlertAction?)
    case dismiss
    case popToRoot
    
    // MARK: OnBoading
    case onBoardingIsRequired
    case loginIsRequired
    case signUpIsRequired
    case certificationIsRequired(email: String)
    
    // MARK: Main
    case clubListIsRequired
    case clubDetailIsRequired(query: ClubRequestQuery)
    case firstNewClubIsRequired
    case secondNewClubIsRequired(reactor: NewClubReactor)
    case thirdNewClubIsRequired(reactor: NewClubReactor)
    case memberAppendIsRequired((([User]) -> Void))
    
    // MARK: Administrator
    case myPageIsRequired
    
}
