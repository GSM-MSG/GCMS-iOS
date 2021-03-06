import RxFlow
import UIKit
import Service
import Loaf

enum GCMSStep: Step {
    // MARK: Global
    case loaf(_ message: String, state: Loaf.State, location: Loaf.Location)
    case alert(title: String?, message: String?, style: UIAlertController.Style, actions: [UIAlertAction])
    case failureAlert(title: String?, message: String?, action:[UIAlertAction] = [])
    case dismiss
    case popToRoot
    
    // MARK: OnBoading
    case onBoardingIsRequired
    
    // MARK: Main
    case clubListIsRequired
    case clubDetailIsRequired(query: ClubRequestQuery)
    
    // MARK: NewClub
    case firstNewClubIsRequired
    case secondNewClubIsRequired(reactor: NewClubReactor)
    case thirdNewClubIsRequired(reactor: NewClubReactor)
    
    // MARK: UpdateClub
    case firstUpdateClubIsRequired(club: Club)
    case secondUpdateClubIsRequired(reactor: UpdateClubReactor)
    
    case memberAppendIsRequired(closure: (([User]) -> Void), clubType: ClubType)
    case clubStatusIsRequired(query: ClubRequestQuery, isHead: Bool, isOpened: Bool)
    
    // MARK: Administrator
    case myPageIsRequired
}
