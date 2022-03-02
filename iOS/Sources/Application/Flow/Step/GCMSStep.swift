import RxFlow

enum GCMSStep: Step {
    // MARK: Global
    case alert(title: String?, message: String?)
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
