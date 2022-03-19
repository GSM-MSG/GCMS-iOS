import RxFlow
import UIKit
import Service

enum GCMSStep: Step {
    // MARK: Global
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case dismiss
    
    // MARK: OnBoading
    case onBoardingIsRequired
    case loginIsRequired
    
    // MARK: Main
    case clubListIsRequired
    case clubDetailIsRequired(query: ClubRequestComponent)
    case newClubIsRequired(category: ClubType)
    case memberAppendIsRequired((([User]) -> Void))
    
    // MARK: Administrator
    case myPageIsRequired
    case clubJoinerListIsRequired(query: ClubRequestComponent)
    
    // MARK: Alarm
    case alarmListIsRequired
}
