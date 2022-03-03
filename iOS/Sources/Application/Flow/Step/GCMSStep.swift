import RxFlow
import UIKit

enum GCMSStep: Step {
    // MARK: Global
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case dismiss
    
    // MARK: OnBoading
    case onBoardingIsRequired
    
    // MARK: Main
    case clubListIsRequired
    case clubDetailIsRequired(Int)
    
    // MARK: Administrator
    case myPageIsRequired
    case clubManagementIsRequired
    case clubJoinerListIsRequired
    case notificationIsRequired
    
    // MARK: Alarm
    case alarmListIsRequired
}
