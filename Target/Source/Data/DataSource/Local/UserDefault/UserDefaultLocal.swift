import Foundation

final class UserDefaultLocal {
    private enum forKeys {
        static let major = "major"
    }
    static let shared = UserDefaultLocal()
    
    private let preferences = UserDefaults.standard
    
    private init() {}
    
    var major: Major {
        get {
            Major(rawValue: preferences.string(forKey: forKeys.major) ?? "") ?? .frontEnd
        }
        set {
            preferences.set(newValue.rawValue, forKey: forKeys.major)
        }
    }
}
