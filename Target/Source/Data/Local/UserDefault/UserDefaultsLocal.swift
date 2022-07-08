import Foundation

final class UserDefaultsLocal {
    enum forKeys {
        static let major = "major"
    }
    static let shared = UserDefaultsLocal()
    
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
