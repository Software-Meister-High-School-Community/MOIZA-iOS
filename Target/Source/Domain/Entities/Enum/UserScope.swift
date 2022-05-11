<<<<<<< HEAD:Target/Source/Domain/Entities/UserScope.swift
public enum UserScope: String, Codable {
=======
enum UserScope: String, Codable, CaseIterable {
>>>>>>> 61a303ea20b03aed75749c04679a6bde00a19ca1:Target/Source/Domain/Entities/Enum/UserScope.swift
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
