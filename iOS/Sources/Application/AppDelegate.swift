import UIKit
import Swinject
import Service
import FirebaseMessaging
import FirebaseCore
import IQKeyboardManagerSwift
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let container = Container()
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GoogleSignIn.GIDSignIn.sharedInstance.restorePreviousSignIn { user, err in
            if err != nil || user == nil {
                // TODO: Error
            } else {
                // TODO: Success
            }
        }
        FirebaseApp.configure()
        setFCM(application)
        AppDelegate.container.registerDependencies()
        AppDelegate.container.registerServiceDependencies()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        
        if handled {
            return true
        }
        
        return false
    }
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        if #available(iOS 14.0, *) {
            return [.badge, .sound, .list, .banner]
        } else {
            return [.alert, .badge, .sound]
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        return
    }
}

private extension AppDelegate {
    func setFCM(_ application: UIApplication){
        UNUserNotificationCenter.current().delegate = self
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOption, completionHandler: { _,_ in } )
        application.registerForRemoteNotifications()
    }
}
