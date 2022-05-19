public enum UserScope: String, Codable, CaseIterable {
    case user = "USER"
    case student = "STUDENT"
    case graduate = "GRADUATE"
}

extension UserScope {
    var display: String {
        switch self {
        case .user, .graduate: return "졸업생"
        case .student: return "재학생"
        }
    }
}
