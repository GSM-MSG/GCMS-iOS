import Foundation

public final class UserDefaultsLocal {
    public enum forKeys {
        public static let isApple = "isapple"
        public static let name = ""
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
    
    var name: String {
        get {
            preferences.string(forKey: forKeys.name) ?? ""
        }
        set {
            preferences.set(newValue, forKey: forKeys.name)
        }
    }
}
