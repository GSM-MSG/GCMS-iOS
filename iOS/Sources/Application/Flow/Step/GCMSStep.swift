import RxFlow
import UIKit
import Service

enum GCMSStep: Step {
    // MARK: Global
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case dismiss
    
    // MARK: OnBoading
    case onBoardingIsRequired
    
    // MARK: Main
    case clubListIsRequired
    case clubDetailIsRequired(id: Int)
    case newClubIsRequired(category: ClubType)
    case memberAppendIsRequired((([User]) -> Void))
    
    // MARK: Administrator
    case myPageIsRequired
    case clubManagementIsRequired
    case clubJoinerListIsRequired(id: Int)
    case notificationIsRequired
    
    // MARK: Alarm
    case alarmListIsRequired
}
