import Foundation

public final class UserDefaultsLocal {
    public enum forKeys {
        public static let isGuest = "isguest"
        public static let isApple = "isapple"
    }
    public static let shared = UserDefaultsLocal()
    private init() {}
    private let preferences = UserDefaults.standard

    public var isGuest: Bool {
        get {
            preferences.bool(forKey: forKeys.isGuest)
        }
        set {
            preferences.set(newValue, forKey: forKeys.isGuest)
        }
    }
    public var isApple: Bool {
        get {
            preferences.bool(forKey: forKeys.isApple)
        }
        set {
            preferences.set(newValue, forKey: forKeys.isApple)
        }
    }
}
