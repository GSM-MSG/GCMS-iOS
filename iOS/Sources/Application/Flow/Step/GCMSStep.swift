import RxFlow

enum GCMSStep: Step {
    // MARK: Global
    case alert(title: String?, message: String?)
    case dismiss
    
    // MARK: OnBoading
    case onBoardingIsRequired
    
    // MARK: Main
    case clubListIsRequired
    case clubDetailIsRequired
    
    // MARK: Administrator
    case myPageIsRequired
    case joinerListIsRequired
    
    // MARK: Alarm
    case alarmListIsRequired
}
