
enum Gender: String, Codable{
    case male = "MALE"
    case female = "FEMALE"
}

extension Gender {
    var display: String {
        switch self {
        case .male: return "남"
        case .female: return "여"
        }
    }
}
