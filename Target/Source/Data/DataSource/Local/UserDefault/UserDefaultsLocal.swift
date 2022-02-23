import Foundation

final class UserDefaultsLocal {
    enum forKeys {
        static let major = "major"
        static let sort = "sort"
        static let post = "post"
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
    
    var sort: SortType {
        get {
            SortType(rawValue: preferences.string(forKey: forKeys.sort) ?? "") ?? .latest
        }
        set {
            preferences.set(newValue.rawValue, forKey: forKeys.sort)
        }
    }
    
    var post: PostType {
        get {
            PostType(rawValue: preferences.string(forKey: forKeys.post) ?? "") ?? .all
        }
        set {
            preferences.set(newValue.rawValue, forKey: forKeys.post)
        }
    }
}
