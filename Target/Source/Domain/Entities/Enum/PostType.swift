
enum PostType: String, Codable, CaseIterable {
    case all = "ALL"
    case normal = "COMMON"
    case question = "QUESTION"
}

extension PostType {
    var display: String {
        switch self {
        case .all, .normal:
            return "일반"
        case .question:
            return "질문"
        }
    }
}
