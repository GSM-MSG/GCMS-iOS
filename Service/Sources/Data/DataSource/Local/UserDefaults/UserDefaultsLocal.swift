import Foundation

public final class UserDefaultsLocal {
    public enum forKeys {
        public static let isApple = "isapple"
    }
    static let shared = UserDefaultsLocal()
    private init() {}
    private let preferences = UserDefaults.standard
    
    var isApple: Bool {
        get {
            preferences.bool(forKey: forKeys.isApple)
        }
        set {
            preferences.set(newValue, forKey: forKeys.isApple)
        }
    }
}

