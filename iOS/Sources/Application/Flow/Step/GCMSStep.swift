import RxFlow
import UIKit
import Service

enum GCMSStep: Step {
    // MARK: Global
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case failureAlert(title: String?, message: String, action: UIAlertAction?)
    case dismiss
    
    // MARK: OnBoading
    case onBoardingIsRequired
    case loginIsRequired
    case certificationIsRequired
    
    // MARK: Main
    case clubListIsRequired
    case clubDetailIsRequired(query: ClubRequestQuery)
    case firstNewClubIsRequired
    case secondNewClubIsRequired(reactor: NewClubReactor)
    case thirdNewClubIsRequired(reactor: NewClubReactor)
    case memberAppendIsRequired((([User]) -> Void))
    
    // MARK: Administrator
    case myPageIsRequired
    case clubJoinerListIsRequired(query: ClubRequestQuery)
    
}
